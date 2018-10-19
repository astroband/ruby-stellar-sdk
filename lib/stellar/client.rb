require 'hyperclient'
require "active_support/core_ext/object/blank"

module Stellar
  class Client
    include Contracts
    C = Contracts

    DEFAULT_FEE = 100

    HORIZON_LOCALHOST_URL = 'http://127.0.0.1:8000'
    HORIZON_MAINNET_URL = 'https://horizon.stellar.org'
    HORIZON_TESTNET_URL = 'https://horizon-testnet.stellar.org'

    def self.default(options={})
      new options.merge(
        horizon: HORIZON_MAINNET_URL
      )
    end

    def self.default_testnet(options={})
      new options.merge(
        horizon:   HORIZON_TESTNET_URL,
        friendbot: HORIZON_TESTNET_URL,
      )
    end

    def self.localhost(options={})
      new options.merge(
        horizon: HORIZON_LOCALHOST_URL
      )
    end

    attr_reader :horizon

    Contract ({horizon: String}) => Any
    def initialize(options)
      @options = options
      @horizon = Hyperclient.new(options[:horizon]) do |client|
        client.faraday_block = lambda do |conn|
          conn.use Faraday::Response::RaiseError
          conn.use FaradayMiddleware::FollowRedirects
          conn.request :url_encoded
          conn.response :hal_json, content_type: /\bjson$/
          conn.adapter :excon
        end
        client.headers = {
          'Accept' => 'application/hal+json,application/problem+json,application/json'
        }
      end
    end

    Contract Stellar::Account => Any
    def account_info(account)
      account_id  = account.address
      @horizon.account(account_id:account_id)._get
    end

    Contract ({
      account:     Stellar::Account,
      destination: Stellar::Account
    }) => Any
    def account_merge(options={})
      account     = options[:account]
      destination = options[:destination]
      sequence    = options[:sequence] || (account_info(account).sequence.to_i + 1)

      transaction = Stellar::Transaction.account_merge({
        account:     account.keypair,
        destination: destination.keypair,
        sequence:    sequence
      })

      envelope_base64 = transaction.to_envelope(account.keypair).to_xdr(:base64)
      @horizon.transactions._post(tx: envelope_base64)
    end

    def friendbot(account)
      raise NotImplementedError
    end

    Contract ({
      account:          Stellar::Account,
      funder:           Stellar::Account,
      starting_balance: Integer
    }) => Any
    def create_account(options={})
      funder   = options[:funder]
      sequence = options[:sequence] || (account_info(funder).sequence.to_i + 1)
      # In the future, the fee should be grabbed from the network's last transactions,
      # instead of using a hard-coded default value.
      fee = options[:fee] || DEFAULT_FEE

      payment = Stellar::Transaction.create_account({
        account:          funder.keypair,
        destination:      options[:account].keypair,
        sequence:         sequence,
        starting_balance: options[:starting_balance],
        fee: fee,
      })

      envelope_base64 = payment.to_envelope(funder.keypair).to_xdr(:base64)
      @horizon.transactions._post(tx: envelope_base64)
    end

    Contract ({
      from:     Stellar::Account,
      to:       Stellar::Account,
      amount:   Stellar::Amount
    }) => Any
    def send_payment(options={})
      from_account     = options[:from]
      tx_source_account = options[:transaction_source] || from_account
      op_source_account = from_account if tx_source_account.present?

      sequence = options[:sequence] ||
        (account_info(tx_source_account).sequence.to_i + 1)

      payment_details = {
        destination: options[:to].keypair,
        sequence:    sequence,
        amount:      options[:amount].to_payment,
        memo:        options[:memo],
      }

      payment_details[:account] = tx_source_account.keypair
      if op_source_account.present?
        payment_details[:source_account] = op_source_account.keypair
      end

      payment = Stellar::Transaction.payment(payment_details)

      to_envelope_args = [tx_source_account.keypair]

      if op_source_account.present? &&
          op_source_account.address != tx_source_account.address
        to_envelope_args << op_source_account.keypair
      end

      envelope_base64 = payment.to_envelope(*to_envelope_args).to_xdr(:base64)
      @horizon.transactions._post(tx: envelope_base64)
    end

    Contract ({
      account:  Maybe[Stellar::Account],
      limit:    Maybe[Pos],
      cursor:   Maybe[String]
    }) => TransactionPage
    def transactions(options={})
      args = options.slice(:limit, :cursor)

      resource = if options[:account]
        args = args.merge(account_id: options[:account].address)
        @horizon.account_transactions(args)
      else
        @horizon.transactions(args)
      end

      TransactionPage.new(resource)
    end

    Contract(C::KeywordArgs[
      asset: [Symbol, String, Xor[Stellar::KeyPair, Stellar::Account]],
      source: Stellar::Account,
      sequence: Maybe[Integer],
      fee: Maybe[Integer],
      limit: Maybe[Integer],
    ] => Any)
    def change_trust(
      asset:,
      source:,
      sequence: nil,
      fee: DEFAULT_FEE,
      limit: nil
    )
      sequence ||= (account_info(source).sequence.to_i + 1)

      args = {
        account: source.keypair,
        sequence: sequence,
        line: asset,
      }
      args[:limit] = limit if !limit.nil?

      tx = Stellar::Transaction.change_trust(args)

      envelope_base64 = tx.to_envelope(source.keypair).to_xdr(:base64)
      horizon.transactions._post(tx: envelope_base64)
    end

  end
end

require 'hyperclient'
require "active_support/core_ext/object/blank"
require 'securerandom'

module Stellar
  class AccountRequiresMemoError < StandardError; end

  class Client
    include Contracts
    C = Contracts

    DEFAULT_FEE = 100

    HORIZON_LOCALHOST_URL = 'http://127.0.0.1:8000'
    HORIZON_MAINNET_URL = 'https://horizon.stellar.org'
    HORIZON_TESTNET_URL = 'https://horizon-testnet.stellar.org'
    FRIENDBOT_URL = 'https://friendbot.stellar.org'.freeze

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
          'Accept' => 'application/hal+json,application/problem+json,application/json',
          "X-Client-Name" => "ruby-stellar-sdk",
          "X-Client-Version" => VERSION,
        }
      end
    end

    Contract Or[Stellar::Account, String] => Any
    def account_info(account_or_address)
      if account_or_address.is_a?(Stellar::Account)
        account_id = account_or_address.address
      else
        account_id = account_or_address
      end
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
      uri = URI.parse(FRIENDBOT_URL)
      uri.query = "addr=#{account.address}"
      Faraday.post(uri.to_s)
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

      signers = [tx_source_account, op_source_account].uniq(&:address)
      to_envelope_args = signers.map(&:keypair)

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

    Contract(C::KeywordArgs[
      tx_envelope: Stellar::TransactionEnvelope,
      options: Maybe[{ skip_memo_required_check: C::Bool }]
    ] => Any)
    def submit_transaction(tx_envelope:, options: { skip_memo_required_check: false })
      if !options[:skip_memo_required_check]
        check_memo_required(tx_envelope)
      end
      @horizon.transactions._post(tx: tx_envelope.to_xdr(:base64))
    end

    Contract Stellar::TransactionEnvelope => Any
    def check_memo_required(tx_envelope)
      tx = tx_envelope.tx
      # Check transactions where the .memo field is nil or of type MemoType.memo_none
      if !tx.memo.nil? && tx.memo.type != Stellar::MemoType.memo_none
        return
      end
      destinations = Set.new
      tx.operations.each do |op|
        if op.body.type == Stellar::OperationType.payment
          destination = op.body.value.destination
        elsif op.body.type == Stellar::OperationType.path_payment_strict_receive
          destination = op.body.value.destination
        elsif op.body.type == Stellar::OperationType.path_payment_strict_send
          destination = op.body.value.destination
        elsif op.body.type == Stellar::OperationType.account_merge
          # There is no AccountMergeOp, op.body is an Operation object
          # and op.body.value is a PublicKey (or AccountID) object.
          destination = op.body.value
        else
          return
        end
        
        if destinations.include?(destination)
          next
        end
        destinations.add(destination)
       
        kp = Stellar::KeyPair.from_public_key(destination.value)
        begin
          info = account_info(kp.address)
        rescue Faraday::ResourceNotFound
          # Don't raise an error if its a 404, but throw one otherwise
          next
        end
        if info.data["config.memo_required"] == "MQ=="
          # MQ== is the base64 encoded string for the string "1"
          raise AccountRequiresMemoError.new("account requires memo")
        end
      end
    end

    Contract(C::KeywordArgs[
      server: Stellar::KeyPair,
      client: Stellar::KeyPair,
      anchor_name: String,
      timeout: C::Optional[Integer]
    ] => String)
    # DEPRECATED: this function has been moved Stellar::SEP10.build_challenge_tx and
    # will be removed in the next major version release.
    #
    # A wrapper function for Stellar::SEP10::build_challenge_tx.
    # 
    # @param server [Stellar::KeyPair] Keypair for server's signing account.
    # @param client [Stellar::KeyPair] Keypair for the account whishing to authenticate with the server.
    # @param anchor_name [String] Anchor's name to be used in the manage_data key.
    # @param timeout [Integer] Challenge duration (default to 5 minutes).
    #
    # @return [String] A base64 encoded string of the raw TransactionEnvelope xdr struct for the transaction.
    def build_challenge_tx(server:, client:, anchor_name:, timeout: 300)
      Stellar::SEP10.build_challenge_tx(
        server: server, client: client, anchor_name: anchor_name, timeout: timeout
      )
    end

    Contract(C::KeywordArgs[
      challenge: String,
      server: Stellar::KeyPair
    ] => C::Bool)    
    # DEPRECATED: this function has been moved to Stellar::SEP10::read_challenge_tx and
    # will be removed in the next major version release.
    #
    # A wrapper function for Stellar::SEP10.verify_challenge_transaction
    #
    # @param challenge [String] SEP0010 transaction challenge in base64.
    # @param server [Stellar::KeyPair] Stellar::KeyPair for server where the challenge was generated.
    #
    # @return [Boolean]
    def verify_challenge_tx(challenge:, server:)
      Stellar::SEP10.verify_challenge_tx(challenge_tx: challenge, server: server)
      true
    end

    Contract(C::KeywordArgs[
      transaction_envelope: Stellar::TransactionEnvelope,
      keypair: Stellar::KeyPair
    ] => C::Bool)
    # DEPRECATED: this function has been moved to Stellar::SEP10::verify_tx_signed_by and
    # will be removed in the next major version release.
    #
    # @param transaction_envelope [Stellar::TransactionEnvelope] 
    # @param keypair [Stellar::KeyPair]
    #
    # @return [Boolean]
    #
    def verify_tx_signed_by(transaction_envelope:, keypair:)
      Stellar::SEP10.verify_tx_signed_by(
        tx_envelope: transaction_envelope, keypair: keypair
      )
    end

  end
end

require "hyperclient"
require "active_support/core_ext/object/blank"
require "active_support/core_ext/hash/keys"
require "securerandom"

module Stellar::Horizon
  class AccountRequiresMemoError < StandardError
    attr_reader :account_id, :operation_index

    def initialize(message, account_id, operation_index)
      super(message)
      @account_id = account_id
      @operation_index = operation_index
    end
  end

  class Client
    include Stellar::DSL

    DEFAULT_FEE = 100

    HORIZON_LOCALHOST_URL = "http://127.0.0.1:8000"
    HORIZON_MAINNET_URL = "https://horizon.stellar.org"
    HORIZON_TESTNET_URL = "https://horizon-testnet.stellar.org"
    FRIENDBOT_URL = "https://friendbot.stellar.org".freeze

    def self.default(options = {})
      new options.merge(
        horizon: HORIZON_MAINNET_URL
      )
    end

    def self.default_testnet(options = {})
      new options.merge(
        horizon: HORIZON_TESTNET_URL,
        friendbot: HORIZON_TESTNET_URL
      )
    end

    def self.localhost(options = {})
      new options.merge(
        horizon: HORIZON_LOCALHOST_URL
      )
    end

    attr_reader :horizon

    # @option options [String] :horizon The Horizon server URL.
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
          "Accept" => "application/hal+json,application/problem+json,application/json",
          "X-Client-Name" => "ruby-stellar-sdk",
          "X-Client-Version" => Stellar::Horizon::VERSION
        }
      end
    end

    # @param [Stellar::Account|String] account_or_address
    def account_info(account_or_address)
      account_id = if account_or_address.is_a?(Stellar::Account)
        account_or_address.address
      else
        account_or_address
      end
      @horizon.account(account_id: account_id)._get
    end

    # @option options [Stellar::Account] :account
    # @option options [Stellar::Account] :destination
    def account_merge(options = {})
      account = options[:account]
      destination = options[:destination]
      sequence = options[:sequence] || (account_info(account).sequence.to_i + 1)

      transaction = Stellar::TransactionBuilder.account_merge(
        source_account: destination.keypair,
        sequence_number: sequence,
        destination: destination.keypair
      )

      envelope = transaction.to_envelope(account.keypair)
      submit_transaction(tx_envelope: envelope)
    end

    def friendbot(account)
      uri = URI.parse(FRIENDBOT_URL)
      uri.query = "addr=#{account.address}"
      Faraday.post(uri.to_s)
    end

    # @option options [Stellar::Account] :account
    # @option options [Stellar::Account] :funder
    # @option options [Integer] :starting_balance
    def create_account(options = {})
      funder = options[:funder]
      sequence = options[:sequence] || (account_info(funder).sequence.to_i + 1)
      # In the future, the fee should be grabbed from the network's last transactions,
      # instead of using a hard-coded default value.
      fee = options[:fee] || DEFAULT_FEE

      payment = Stellar::TransactionBuilder.create_account(
        source_account: funder.keypair,
        sequence_number: sequence,
        base_fee: fee,
        destination: options[:account].keypair,
        starting_balance: options[:starting_balance]
      )
      envelope = payment.to_envelope(funder.keypair)
      submit_transaction(tx_envelope: envelope)
    end

    # Requests /claimable_balances endpoint with given parameters
    #
    # @param [Stellar::Asset|String] asset
    # @param [Stellar::Account|String] claimant
    # @param [Stellar::Account|String] sponsor
    def claimable_balances(asset: nil, claimant: nil, sponsor: nil)
      resource = @horizon.claimable_balances(
        asset: asset.presence && Asset(asset).to_s,
        claimant: claimant.presence && Account(claimant).address,
        sponsor: sponsor.presence && Account(sponsor).address
      )
      Stellar::Horizon::ClaimableBalancePage.new(resource)
    end

    # @option options [Stellar::Account] :from The source account
    # @option options [Stellar::Account] :to The destination account
    # @option options [Stellar::Amount] :amount The amount to send
    def send_payment(options = {})
      from_account = options[:from]
      tx_source_account = options[:transaction_source] || from_account
      op_source_account = from_account if tx_source_account.present?

      sequence = options[:sequence] ||
        (account_info(tx_source_account).sequence.to_i + 1)

      payment = Stellar::TransactionBuilder.new(
        source_account: tx_source_account.keypair,
        sequence_number: sequence
      ).add_operation(
        Stellar::Operation.payment(
          source_account: op_source_account.keypair,
          destination: options[:to].keypair,
          amount: options[:amount].to_payment
        )
      ).set_memo(options[:memo]).set_timeout(0).build

      signers = [tx_source_account, op_source_account].uniq(&:address)
      to_envelope_args = signers.map(&:keypair)

      envelope = payment.to_envelope(*to_envelope_args)
      submit_transaction(tx_envelope: envelope)
    end

    # @option options [Stellar::Account] :account
    # @option options [Integer] :limit
    # @option options [Integer] :cursor
    # @return [ResourcePage]
    def transactions(options = {})
      args = options.slice(:limit, :cursor)

      resource = if options[:account]
        args = args.merge(account_id: Account(options[:account]).address)
        @horizon.account_transactions(args)
      else
        @horizon.transactions(args)
      end

      Stellar::Horizon::ResourcePage.new(resource)
    end

    # @param [Array(Symbol,String,Stellar::KeyPair|Stellar::Account)] asset
    # @param [Stellar::Account] source
    # @param [Integer] sequence
    # @param [Integer] fee
    # @param [Integer] limit
    def change_trust(
      asset:,
      source:,
      sequence: nil,
      fee: DEFAULT_FEE,
      limit: nil
    )
      sequence ||= (account_info(source).sequence.to_i + 1)

      op_args = {
        account: source.keypair,
        sequence: sequence,
        asset: asset
      }
      op_args[:limit] = limit unless limit.nil?

      tx = Stellar::TransactionBuilder.change_trust(
        source_account: source.keypair,
        sequence_number: sequence,
        **op_args
      )

      envelope = tx.to_envelope(source.keypair)
      submit_transaction(tx_envelope: envelope)
    end

    # @param [Stellar::TransactionEnvelope] tx_envelope
    # @option options [Boolean] :skip_memo_required_check (false)
    def submit_transaction(tx_envelope:, options: {skip_memo_required_check: false})
      unless options[:skip_memo_required_check]
        check_memo_required(tx_envelope)
      end
      @horizon.transactions._post(tx: tx_envelope.to_xdr(:base64))
    end

    # Required by SEP-0029
    # @param [Stellar::TransactionEnvelope] tx_envelope
    def check_memo_required(tx_envelope)
      tx = tx_envelope.tx

      if tx.is_a?(Stellar::FeeBumpTransaction)
        tx = tx.inner_tx.v1!.tx
      end

      # Check transactions where the .memo field is nil or of type MemoType.memo_none
      if !tx.memo.nil? && tx.memo.type != Stellar::MemoType.memo_none
        return
      end

      destinations = Set.new
      ot = Stellar::OperationType

      tx.operations.each_with_index do |op, idx|
        destination = case op.body.type
        when ot.payment, ot.path_payment_strict_receive, ot.path_payment_strict_send
          op.body.value.destination
        when ot.account_merge
          # There is no AccountMergeOp, op.body is an Operation object
          # and op.body.value is a PublicKey (or AccountID) object.
          op.body.value
        else
          next
        end

        if destinations.include?(destination) || destination.switch == Stellar::CryptoKeyType.key_type_muxed_ed25519
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
          raise AccountRequiresMemoError.new("account requires memo", destination, idx)
        end
      end
    end
  end
end

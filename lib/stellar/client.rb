require 'hyperclient'
require "active_support/core_ext/object/blank"

module Stellar
  class InvalidSep10ChallengeError < StandardError; end

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
      server: Stellar::KeyPair,
      client: Stellar::KeyPair,
      anchor_name: String,
      timeout: C::Optional[Integer]
    ] => String)
    #
    # Helper method to create a valid {SEP0010}[https://github.com/stellar/stellar-protocol/blob/master/ecosystem/sep-0010.md]
    # challenge transaction which you can use for Stellar Web Authentication.
    #    
    # @param server [Stellar::KeyPair] Keypair for server's signing account.
    # @param client [Stellar::KeyPair] Keypair for the account whishing to authenticate with the server.
    # @param anchor_name [String] Anchor's name to be used in the manage_data key.
    # @param timeout [Integer] Challenge duration (default to 5 minutes).
    #
    # @return [String] A base64 encoded string of the raw TransactionEnvelope xdr struct for the transaction.
    #
    # = Example
    # 
    #   client = Stellar::Client.default_testnet
    #   client.build_challenge_tx(server: server, client: user, anchor_name: anchor, timeout: timeout) 
    # 
    # @see {SEP0010: Stellar Web Authentication}[https://github.com/stellar/stellar-protocol/blob/master/ecosystem/sep-0010.md]
    def build_challenge_tx(server:, client:, anchor_name:, timeout: 300)
      # The value must be 64 bytes long. It contains a 48 byte
      # cryptographic-quality random string encoded using base64 (for a total of
      # 64 bytes after encoding).
      value = [Random.bytes(48)].pack("m0")
            
      tx = Stellar::Transaction.manage_data({
        account: server,
        sequence:  0,
        name: "#{anchor_name} auth", 
        value: value,
        source_account: client
      })

      now = Time.now.to_i
      tx.time_bounds = Stellar::TimeBounds.new(
        min_time: now, 
        max_time: now + timeout
      )

      tx.to_envelope(server).to_xdr(:base64)
    end

   Contract(C::KeywordArgs[
     challenge: String,
     server: Stellar::KeyPair
   ] => C::Bool)    
   # Verifies if challenge input is a valid {SEP0010}[https://github.com/stellar/stellar-protocol/blob/master/ecosystem/sep-0010.md]
   # challenge transaction.
   #
   # This method performs the following checks:
   #
   #   1. Verifies that the transaction's source is the same as the server account id.
   #   2. Verifies that the number of operations in the transaction is equal to one and of type manageData.
   #   3. Verifies if timeBounds are still valid.
   #   4. Verifies if the transaction has been signed by the server and the client.
   #   5. Verifies that the sequenceNumber is equal to zero.
   #
   # @param challenge [String] SEP0010 transaction challenge in base64.
   # @param server [Stellar::KeyPair] Stellar::KeyPair for server where the challenge was generated.
   #
   # @return [Boolean]
   #
   # = Example
   # 
   #   client = Stellar::Client.default_testnet
   #   challenge = client.build_challenge_tx(server: server, client: user, anchor_name: anchor, timeout: timeout) 
   #   client.verify_challenge_tx(challenge: challenge, server: server)
   #
   def verify_challenge_tx(challenge:, server:)
      envelope = Stellar::TransactionEnvelope.from_xdr(challenge, "base64") 
      transaction = envelope.tx

      if transaction.seq_num != 0
        raise InvalidSep10ChallengeError.new(
          "The transaction sequence number should be zero"
        )
      end  

      if transaction.source_account != server.public_key
        raise InvalidSep10ChallengeError.new(
          "The transaction source account is not equal to the server's account"
        )
      end
  
      if transaction.operations.size != 1
        raise InvalidSep10ChallengeError.new(
          "The transaction should contain only one operation"
        )
      end
  
      operation = transaction.operations.first
  
      if operation.source_account.nil?
        raise InvalidSep10ChallengeError.new(
          "The transaction's operation should contain a source account"
        )
      end
  
      if operation.body.arm != :manage_data_op
        raise InvalidSep10ChallengeError.new(
          "The transaction's operation should be manageData"
        )
      end
  
      if operation.body.value.data_value.unpack("m")[0].size !=  48
        raise InvalidSep10ChallengeError.new(
          "The transaction's operation value should be a 64 bytes base64 random string"
        )
      end

      if !verify_tx_signed_by(transaction_envelope: envelope, keypair: server)
        raise InvalidSep10ChallengeError.new(
          "The transaction is not signed by the server"
        )
      end

      client_pk = Stellar::KeyPair.from_public_key(operation.source_account.value)
      if !verify_tx_signed_by(transaction_envelope: envelope, keypair: client_pk)
        raise InvalidSep10ChallengeError.new(
          "The transaction is not signed by the client"
        )
      end
  
      time_bounds = transaction.time_bounds
      now = Time.now.to_i

      if time_bounds.nil? || !now.between?(time_bounds.min_time, time_bounds.max_time)
        raise InvalidSep10ChallengeError.new("The transaction has expired")        
      end

      true
    end

    Contract(C::KeywordArgs[
      transaction_envelope: Stellar::TransactionEnvelope,
      keypair: Stellar::KeyPair
    ] => C::Bool)    
    # Verifies if a Stellar::TransactionEnvelope was signed by the given Stellar::KeyPair
    #
    # @param transaction_envelope [Stellar::TransactionEnvelope] 
    # @param keypair [Stellar::KeyPair]
    #
    # @return [Boolean]
    #
    # = Example
    # 
    #   client = Stellar::Client.default_testnet
    #   client.verify_tx_signed_by(transaction_envelope: envelope, keypair: keypair)
    #
    def verify_tx_signed_by(transaction_envelope:, keypair:)
      hashed_signature_base = transaction_envelope.tx.hash

      !!transaction_envelope.signatures.find do |sig| 
        keypair.verify(sig.signature, hashed_signature_base)
      end
    end
  end
end

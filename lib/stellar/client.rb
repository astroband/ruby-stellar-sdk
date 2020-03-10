require 'hyperclient'
require "active_support/core_ext/object/blank"
require 'securerandom'

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

    Contract Stellar::Account => nil
    def load_account_signers(account)
      info = account_info(account)
      account.signers = Array.new
      info.signers.each do |signer|
        account.signers.push(
          Stellar::AccountSigner.new(
            signer['key'], 
            signer['weight'].to_i
          )
        )
      end
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
      value = SecureRandom.base64(48)
            
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
   ] => C::ArrayOf[Or[Stellar::TransactionEnvelope, Stellar::PublicKey]])    
   # Reads a SEP 10 challenge transaction and returns the decoded transaction envelope and client account ID contained within.
   #
   # It also verifies that transaction is signed by the server.
   #
   # It does not verify that the transaction has been signed by the client or
   # that any signatures other than the servers on the transaction are valid. Use
   # one of the following functions to completely verify the transaction:
   #    - Stellar::Client.verify_challenge_transaction_threshold
   #    - Stellar::Client.verify_challenge_transaction_signers
   #
   # @param challenge [String] SEP0010 transaction challenge in base64.
   # @param server [Stellar::KeyPair] Stellar::KeyPair for server where the challenge was generated.
   #
   # @return [ArrayOf[Or[Stellar::TransactionEnvelope, Stellar::PublicKey]]]
   #
   # = Example
   # 
   #   client = Stellar::Client.default_testnet
   #   challenge = client.build_challenge_tx(server: server, client: user, anchor_name: anchor, timeout: timeout) 
   #   envelope, client_id = client.read_challenge_tx(challenge: challenge, server: server)
   #
   def read_challenge_tx(challenge:, server:)
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
      client_account_id = operation.source_account
  
      if client_account_id.nil?
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

      time_bounds = transaction.time_bounds
      now = Time.now.to_i

      if time_bounds.nil? || !now.between?(time_bounds.min_time, time_bounds.max_time)
        raise InvalidSep10ChallengeError.new("The transaction has expired")        
      end

      return envelope, client_account_id
    end

    Contract(C::KeywordArgs[
      challenge: String,
      server: Stellar::KeyPair,
      signers: ArrayOf[Stellar::AccountSigner]
    ] => C::ArrayOf[Stellar::AccountSigner])
    # Verifies that for a SEP 10 challenge transaction all signatures on the transaction are accounted for.
    #
    # A transaction is verified if it is signed by the server account, and all other signatures match a signer 
    # that has been provided as an argument. Additional signers can be provided that do not have a signature, 
    # but all signatures must be matched to a signer for verification to succeed. 
    #
    # If verification succeeds a list of signers that were found is returned, excluding the server account ID.
    #
    # @param challenge_transaction [String] SEP0010 transaction challenge transaction in base64.
    # @param server [Stellar::Keypair] keypair for server's account.
    # @param signers [ArrayOf[Stellar::AccountSigner]] The signers of client account.
    #
    # @return [ArrayOf[Stellar::AccountSigner]]
    #
    # Raises a InvalidSep10ChallengeError if:
    #     - The transaction is invalid according to Stellar::Client.read_challenge_transaction.
    #     - One or more signatures in the transaction are not identifiable as the server account or one of the 
    #       signers provided in the arguments.
    def verify_challenge_transaction_signers(
      challenge_transaction:,
      server:,
      signers:
    )
      if !signers
        raise InvalidSep10ChallengeError.new("No signers provided.")
      end

      te, _ = read_challenge_transaction(challenge: challenge_transaction, server: server)

      # Remove the server signer from the signers list if it is present. It's
      # important when verifying signers of a challenge transaction that we only
      # verify and return client signers. If an account has the server as a
      # signer the server should not play a part in the authentication of the
      # client.
      client_signers = Array.new
      signers.each do |signer|
        if signer.address != server.address
          client_signers.push(signer)
        end
      end

      # Verify all the transaction's signers (server and client) in one
      # hit. We do this in one hit here even though the server signature was
      # checked in the read_challenge_transaction to ensure that every signature and signer
      # are consumed only once on the transaction.
      all_signers = client_signers + [Stellar::AccountSigner.new(server.address)]
      all_signers_found = verify_transaction_signatures(te, all_signers)

      signers_found = Array.new
      server_signer_found = false
      all_signers.each do |signer|
        if signer.address == server.address
          server_signer_found = true
          next
        end
        # Deduplicate the client signers
        if signer_in_signers(signer, signers_found)
          next
        end
        signers_found.push(signer)
      end

      # Confirm we matched a signature to the server signer.
      if !server_signer_found
        raise InvalidSep10ChallengeError.new(
          "Transaction not signed by server: %s." % [server.address]
        )
      end

      # Confirm we matched signatures to the client signers.
      if !signers_found
        raise InvalidSep10ChallengeError.new("Transaction not signed by any client signer.")
      end

      # Confirm all signatures were consumed by a signer.
      if all_signers_found.length != te.signatures.length
        raise InvalidSep10ChallengeError("Transaction has unrecognized signatures.")
      end

      return signers_found

    end

    Contract(C::KeywordArgs[
      challenge_transaction: Stellar::TransactionEnvelope, 
      server: Stellar::KeyPair
    ])
    # An alias for Stellar::Client.verify_challenge_transaction(challenge_transaction)
    # 
    # @param challenge_transaction [Stellar::TransactionEnvelope] SEP0010 transaction challenge transaction in base64.
    # @param server [Stellar::KeyPair] the server's signing keypair
    def verify_challenge_transaction_signed_by_client_master_key(
      challenge_transaction:, server_account_id:
    )
      verify_challenge_transaction(
        challenge_transaction: challenge_transaction, server: server
      )
    end

    Contract(C::KeywordArgs[
      challenge_transaction: String,
      server_account_id: String,
      network_passphrase: String,
      threshold: Num,
      signers: ArrayOf[Stellar::AccountSigner],
    ] => ArrayOf[Stellar::AccountSigner])
    # Verifies that for a SEP 10 challenge transaction all signatures on the transaction 
    # are accounted for and that the signatures meet a threshold on an account. A 
    # transaction is verified if it is signed by the server account, and all other 
    # signatures match a signer that has been provided as an argument, and those 
    # signatures meet a threshold on the account.
    #
    # @param challenge_transaction [String] SEP0010 transaction challenge transaction in base64.
    # @param server [Stellar::KeyPair] keypair for server's account.
    # @param threshold [Num] The medThreshold on the client account.
    # @param signers The signers of client account.
    #
    # @return [ArrayOf[Stellar::AccountSigner]]
    #
    # Raises a InvalidSep10ChallengeError if:
    #   - The transaction is invalid according to Stellar::Client.read_challenge_transaction.
    #   - One or more signatures in the transaction are not identifiable as the server 
    #     account or one of the signers provided in the arguments.
    #   - The signatures are all valid but do not meet the threshold.
    def verify_challenge_transaction_threshold(
      challenge_transaction:,
      server:,
      network_passphrase:,
      threshold:,
      signers:
    )
      signers_found = verify_challenge_transaction_signers(
        challenge_transaction: challenge_transaction, 
        server: server, 
        signers: signers
      )
  
      weight = 0
      signers_found.each do |s|
        weight += s.weight
      end

      if weight < threshold
        raise InvalidSep10ChallengeError.new(
          "signers with weight %d do not meet threshold %d." % [weight, threshold]
        )
      end
  
      return signers_found
    end

    Contract(C::KeywordArgs[
      challenge_transaction: String, 
      server: Stellar::KeyPair
    ])
    # Verifies if a transaction is a valid per SEP-10 challenge transaction, if the validation 
    # fails, an exception will be thrown.
    #
    # This function performs the following checks:
    #   1. verify that transaction sequenceNumber is equal to zero;
    #   2. verify that transaction source account is equal to the server's signing key;
    #   3. verify that transaction has time bounds set, and that current time is between the minimum and maximum bounds;
    #   4. verify that transaction contains a single Manage Data operation and it's source account is not null;
    #   5. verify that transaction envelope has a correct signature by server's signing key;
    #   6. verify that transaction envelope has a correct signature by the operation's source account;
    #
    # @param challenge_transaction [String] SEP0010 transaction challenge transaction in base64.
    # @param server [Stellar::KeyPair] keypair for server's account.
    #
    # Raises a InvalidSep10ChallengeError if the validation fails, the exception will be thrown.
    def verify_challenge_transaction(
      challenge_transaction: String, server: String
    )
      transaction_envelope, client_account_id = read_challenge_transaction(
          challenge: challenge_transaction, server: server
      )
      client_keypair = Stellar::KeyPair.from_public_key(client_account_id)
      if !verify_te_signed_by(transaction_envelope: transaction_envelope, keypair: client_keypair)
        raise InvalidSep10ChallengeError.new(
            "Transaction not signed by client: %s" % [client_keypair.address]
        )
      end
    end

    Contract(C::KeywordArgs[
      transaction_envelope: Stellar::TransactionEnvelope, 
      signers: ArrayOf[Stellar::AccountSigner]
    ] => ArrayOf[Stellar::AccountSigner])
    # Checks if a transaction has been signed by one or more of
    # the signers, returning a list of signers that were found to have signed the
    # transaction.
    #
    # @param transaction_envelope [Stellar::TransactionEnvelope] SEP0010 transaction challenge transaction envelope.
    # @param signers [ArrayOf[Stellar::AccountSigner]] The signers of client account.
    #
    # @return [ArrayOf[Stellar::AccountSigner]]
    def verify_transaction_signatures(
      transaction_envelope:,
      signers:
    )
      signatures = transaction_envelope.signatures
      if !signatures
        raise InvalidSep10ChallengeError.new("Transaction has no signatures.")
      end
  
      tx_hash = transaction_envelope.hash()
  
      signers_found = Array.new
      signature_used = Set.new
      signers.each do |signer|
        kp = Stellar::KeyPair.from_address(signer.address)
        signatures.each_with_index do |decorated_signature, index|
          if signature_used.include?(index)
            next
          end
          if decorated_signature.hint != kp.signature_hint()
            next
          end
          begin
            kp.verify(tx_hash, decorated_signature.signature)
            signature_used.add(index)
            signers_found.push(signer)
            break
          rescue RbNaCl::BadSignatureError
          end
        end
      end

      return signers_found
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

      transaction_envelope.signatures.any? do |sig| 
        keypair.verify(sig.signature, hashed_signature_base)
      end
    end

    Contract(C::KeywordArgs[
      signer: Stellar::AccountSigner,
      signers: ArrayOf[AccountSigner]
    ] => C::Bool)
    # Checks if a signer is in signers by comparing account addresses
    #
    # @param signer [Stellar::AccountSigner]
    # @param signers [Arrayof[AccountSigner]]
    #
    # @return [Boolean]
    def signer_in_signers(signer:, signers:)
      signers.each.any? do |s|
        s.address == signer.address
      end
    end

  end
end

module Stellar
  class InvalidSep10ChallengeError < StandardError; end

  class SEP10
    include Contracts
    C = Contracts

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
    #   Stellar::SEP10.build_challenge_tx(server: server, client: user, anchor_name: anchor, timeout: timeout) 
    # 
    # @see {SEP0010: Stellar Web Authentication}[https://github.com/stellar/stellar-protocol/blob/master/ecosystem/sep-0010.md]
    def self.build_challenge_tx(server:, client:, anchor_name:, timeout: 300)
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
      challenge_xdr: String,
      server: Stellar::KeyPair
    ] => [Stellar::TransactionEnvelope, String])    
    # Reads a SEP 10 challenge transaction and returns the decoded transaction envelope and client account ID contained within.
    #
    # It also verifies that transaction is signed by the server.
    #
    # It does not verify that the transaction has been signed by the client or
    # that any signatures other than the servers on the transaction are valid. Use
    # one of the following functions to completely verify the transaction:
    #    - Stellar::SEP10.verify_challenge_tx_threshold
    #    - Stellar::SEP10.verify_challenge_tx_signers
    #
    # @param challenge_xdr [String] SEP0010 transaction challenge in base64.
    # @param server [Stellar::KeyPair] keypair for server where the challenge was generated.
    #
    # @return [Stellar::TransactionEnvelope, String]
    #
    # = Example
    # 
    #   sep10 = Stellar::SEP10
    #   challenge = sep10.build_challenge_tx(server: server, client: user, anchor_name: anchor, timeout: timeout) 
    #   envelope, client_address = sep10.read_challenge_tx(challenge: challenge, server: server)
    #
    def self.read_challenge_tx(challenge_xdr:, server:)
      envelope = Stellar::TransactionEnvelope.from_xdr(challenge_xdr, "base64") 
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

      if !verify_tx_signed_by(tx_envelope: envelope, keypair: server)
        raise InvalidSep10ChallengeError.new(
          "The transaction is not signed by the server"
        )
      end

      time_bounds = transaction.time_bounds
      now = Time.now.to_i

      if time_bounds.nil? || !now.between?(time_bounds.min_time, time_bounds.max_time)
        raise InvalidSep10ChallengeError.new("The transaction has expired")        
      end

      # Mirror the return type of the other SDK's and return a string
      client_kp = Stellar::KeyPair.from_public_key(client_account_id.ed25519!)

      return envelope, client_kp.address
    end


    Contract(C::KeywordArgs[
      challenge_xdr: String,
      server: Stellar::KeyPair,
      signers: SetOf[Stellar::AccountSigner]
    ] => C::SetOf[Stellar::AccountSigner])
    # Verifies that for a SEP 10 challenge transaction all signatures on the transaction are accounted for.
    #
    # A transaction is verified if it is signed by the server account, and all other signatures match a signer 
    # that has been provided as an argument. Additional signers can be provided that do not have a signature, 
    # but all signatures must be matched to a signer for verification to succeed. 
    #
    # If verification succeeds a list of signers that were found is returned, excluding the server account ID.
    #
    # @param challenge_xdr [String] SEP0010 transaction challenge transaction in base64.
    # @param server [Stellar::Keypair] keypair for server's account.
    # @param signers [SetOf[Stellar::AccountSigner]] The signers of client account.
    #
    # @return [SetOf[Stellar::AccountSigner]]
    #
    # Raises a InvalidSep10ChallengeError if:
    #     - The transaction is invalid according to Stellar::SEP10.read_challenge_tx.
    #     - One or more signatures in the transaction are not identifiable as the server account or one of the 
    #       signers provided in the arguments.
    def self.verify_challenge_tx_signers(
      challenge_xdr:,
      server:,
      signers:
    )
      if signers.empty?
        raise InvalidSep10ChallengeError.new("No signers provided.")
      end

      te, _ = read_challenge_tx(
        challenge_xdr: challenge_xdr, server: server
      )

      # Remove the server signer from the signers list if it is present. It's
      # important when verifying signers of a challenge transaction that we only
      # verify and return client signers. If an account has the server as a
      # signer the server should not play a part in the authentication of the
      # client. We also ignore non-G addresses.
      client_signers = Set.new
      signers.each do |signer|
        if signer.address != server.address and signer.address.start_with?('G')
          client_signers.add(signer)
        end
      end

      signers_found = verify_tx_signatures(
        tx_envelope: te, signers: client_signers
      )

      # Confirm we matched signatures to the client signers.
      if signers_found.empty?
        raise InvalidSep10ChallengeError.new("Transaction not signed by any client signer.")
      end

      # Confirm all signatures were consumed by a signer.
      if signers_found.length != te.signatures.length - 1
        raise InvalidSep10ChallengeError.new("Transaction has unrecognized signatures.")
      end

      return signers_found

    end

    Contract(C::KeywordArgs[
      challenge_xdr: String,
      server: Stellar::KeyPair,
      threshold: Integer,
      signers: SetOf[Stellar::AccountSigner],
    ] => C::SetOf[Stellar::AccountSigner])
    # Verifies that for a SEP 10 challenge transaction all signatures on the transaction 
    # are accounted for and that the signatures meet a threshold on an account. A 
    # transaction is verified if it is signed by the server account, and all other 
    # signatures match a signer that has been provided as an argument, and those 
    # signatures meet a threshold on the account.
    #
    # @param challenge_xdr [String] SEP0010 transaction challenge transaction in base64.
    # @param server [Stellar::KeyPair] keypair for server's account.
    # @param threshold [Integer] The medThreshold on the client account.
    # @param signers [SetOf[Stellar::AccountSigner]]The signers of client account.
    #
    # @return [SetOf[Stellar::AccountSigner]]
    #
    # Raises a InvalidSep10ChallengeError if:
    #   - The transaction is invalid according to Stellar::SEP10.read_challenge_transaction.
    #   - One or more signatures in the transaction are not identifiable as the server 
    #     account or one of the signers provided in the arguments.
    #   - The signatures are all valid but do not meet the threshold.
    def self.verify_challenge_tx_threshold(
      challenge_xdr:,
      server:,
      threshold:,
      signers:
    )
      signers_found = verify_challenge_tx_signers(
        challenge_xdr: challenge_xdr, 
        server: server, 
        signers: signers
      )
  
      weight = 0
      signers_found.each do |s|
        weight += s.weight
      end

      if weight < threshold
        raise InvalidSep10ChallengeError.new(
          "signers with weight %{w} do not meet threshold %{t}." % {w: weight, t: threshold}
        )
      end
  
      return signers_found
    end

    Contract(C::KeywordArgs[
      challenge_xdr: String, 
      server: Stellar::KeyPair
    ] => nil)
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
    # @param challenge_xdr [String] SEP0010 transaction challenge transaction in base64.
    # @param server [Stellar::KeyPair] keypair for server's account.
    #
    # Raises a InvalidSep10ChallengeError if the validation fails
    def self.verify_challenge_tx(
      challenge_xdr: String, server: Stellar::KeyPair
    )
      transaction_envelope, client_address = read_challenge_tx(
          challenge_xdr: challenge_xdr, server: server
      )
      client_keypair = Stellar::KeyPair.from_address(client_address)
      if !verify_tx_signed_by(tx_envelope: transaction_envelope, keypair: client_keypair)
        raise InvalidSep10ChallengeError.new(
            "Transaction not signed by client: %s" % [client_keypair.address]
        )
      end
    end

    Contract(C::KeywordArgs[
      tx_envelope: Stellar::TransactionEnvelope, 
      signers: SetOf[Stellar::AccountSigner]
    ] => SetOf[Stellar::AccountSigner])
    # Checks if a transaction has been signed by one or more of the signers, 
    # returning a list of unique signers that were found to have signed the transaction.
    #
    # @param tx_envelope [Stellar::TransactionEnvelope] SEP0010 transaction challenge transaction envelope.
    # @param signers [SetOf[Stellar::AccountSigner]] The signers of client account.
    #
    # @return [SetOf[Stellar::AccountSigner]]
    def self.verify_tx_signatures(
      tx_envelope:,
      signers:
    )
      signatures = tx_envelope.signatures
      if signatures.empty?
        raise InvalidSep10ChallengeError.new("Transaction has no signatures.")
      end

      signers_found = Set.new
      signers.each do |signer|
        kp = Stellar::KeyPair.from_address(signer.address)
        if verify_tx_signed_by(tx_envelope: tx_envelope, keypair: kp)
          signers_found.add(signer)
        end
      end

      return signers_found
    end

    Contract(C::KeywordArgs[
      tx_envelope: Stellar::TransactionEnvelope,
      keypair: Stellar::KeyPair
    ] => C::Bool)
    # Verifies if a Stellar::TransactionEnvelope was signed by the given Stellar::KeyPair
    #
    # @param tx_envelope [Stellar::TransactionEnvelope] 
    # @param keypair [Stellar::KeyPair]
    #
    # @return [Boolean]
    #
    # = Example
    # 
    #   Stellar::SEP10.verify_tx_signed_by(tx_envelope: envelope, keypair: keypair)
    #
    def self.verify_tx_signed_by(tx_envelope:, keypair:)
      tx_hash = tx_envelope.tx.hash
      tx_envelope.signatures.any? do |sig| 
        if sig.hint != keypair.signature_hint
          next
        end
        keypair.verify(sig.signature, tx_hash)
      end
    end

  end
end
module Stellar
  class InvalidSep10ChallengeError < StandardError; end

  class SEP10
    include Stellar::DSL

    # Helper method to create a valid {SEP0010}[https://github.com/stellar/stellar-protocol/blob/master/ecosystem/sep-0010.md]
    # challenge transaction which you can use for Stellar Web Authentication.
    #
    # @example
    #   server = Stellar::KeyPair.random # SIGNING_KEY from your stellar.toml
    #   user = Stellar::KeyPair.from_address('G...')
    #   Stellar::SEP10.build_challenge_tx(server: server, client: user, domain: 'example.com', timeout: 300)
    #
    # @param server [Stellar::KeyPair] server's signing keypair (SIGNING_KEY in service's stellar.toml)
    # @param client [Stellar::KeyPair] account trying to authenticate with the server
    # @param home_domain [String] service's domain to be used in the manage_data key
    # @param timeout [Integer] challenge duration (default to 5 minutes)
    #
    # @return [String] A base64 encoded string of the raw TransactionEnvelope xdr struct for the transaction.
    #
    # @see {SEP0010: Stellar Web Authentication}[https://github.com/stellar/stellar-protocol/blob/master/ecosystem/sep-0010.md]
    def self.build_challenge_tx(server:, client:, home_domain: nil, timeout: 300, **options)
      if home_domain.blank? && options.key?(:anchor_name)
        ActiveSupport::Deprecation.new("next release", "stellar-sdk").warn <<~MSG
          SEP-10 v2.0.0 requires usage of service home domain instead of anchor name in the challenge transaction.
          Please update your implementation to use `Stellar::SEP10.build_challenge_tx(..., home_domain: 'example.com')`.
          Using `anchor_name` parameter makes your service incompatible with SEP10-2.0 clients, support for this parameter
          is deprecated and will be removed in the next major release of stellar-base.
        MSG
        home_domain = options[:anchor_name]
      end

      now = Time.now.to_i
      time_bounds = Stellar::TimeBounds.new(
        min_time: now,
        max_time: now + timeout
      )

      tb = Stellar::TransactionBuilder.new(
        source_account: server,
        sequence_number: 0,
        time_bounds: time_bounds
      )

      # The value must be 64 bytes long. It contains a 48 byte
      # cryptographic-quality random string encoded using base64 (for a total of
      # 64 bytes after encoding).
      tb.add_operation(
        Stellar::Operation.manage_data(
          name: "#{home_domain} auth",
          value: SecureRandom.base64(48),
          source_account: client
        )
      )

      if options.key?(:auth_domain)
        tb.add_operation(
          Stellar::Operation.manage_data(
            name: "web_auth_domain",
            value: options[:auth_domain],
            source_account: server
          )
        )
      end

      tb.build.to_envelope(server).to_xdr(:base64)
    end

    # Reads a SEP 10 challenge transaction and returns the decoded transaction envelope and client account ID contained within.
    #
    # It also verifies that transaction is signed by the server.
    #
    # It does not verify that the transaction has been signed by the client or
    # that any signatures other than the servers on the transaction are valid.
    # Use either {.verify_challenge_tx_threshold} or {.verify_challenge_tx_signers} to completely verify
    # the signed challenge
    #
    # @example
    #   sep10 = Stellar::SEP10
    #   server = Stellar::KeyPair.random # this should be the SIGNING_KEY from your stellar.toml
    #   challenge = sep10.build_challenge_tx(server: server, client: user, home_domain: domain, timeout: timeout)
    #   envelope, client_address = sep10.read_challenge_tx(server: server, challenge_xdr: challenge)
    #
    # @param challenge_xdr [String] SEP0010 transaction challenge in base64.
    # @param server [Stellar::KeyPair] keypair for server where the challenge was generated.
    #
    # @return [Array(Stellar::TransactionEnvelope, String)]
    def self.read_challenge_tx(server:, challenge_xdr:, **options)
      envelope = Stellar::TransactionEnvelope.from_xdr(challenge_xdr, "base64")
      transaction = envelope.tx

      if transaction.seq_num != 0
        raise InvalidSep10ChallengeError, "The transaction sequence number should be zero"
      end

      if transaction.source_account != server.muxed_account
        raise InvalidSep10ChallengeError, "The transaction source account is not equal to the server's account"
      end

      if transaction.operations.size < 1
        raise InvalidSep10ChallengeError, "The transaction should contain at least one operation"
      end

      auth_op, *rest_ops = transaction.operations
      client_account_id = auth_op.source_account

      if client_account_id.blank?
        raise InvalidSep10ChallengeError, "The transaction's operation should contain a source account"
      end

      if auth_op.body.arm != :manage_data_op
        raise InvalidSep10ChallengeError, "The transaction's first operation should be manageData"
      end

      if auth_op.body.value.data_value.unpack1("m").size != 48
        raise InvalidSep10ChallengeError, "The transaction's operation value should be a 64 bytes base64 random string"
      end

      rest_ops.each do |op|
        body = op.body

        if body.arm != :manage_data_op
          raise InvalidSep10ChallengeError, "The transaction has operations that are not of type 'manageData'"
        elsif op.source_account != server.muxed_account
          raise InvalidSep10ChallengeError, "The transaction has operations that are unrecognized"
        else
          op_params = body.value
          if op_params.data_name == "web_auth_domain" && options.key?(:auth_domain) && op_params.data_value != options[:auth_domain]
            raise InvalidSep10ChallengeError, "The transaction has 'manageData' operation with 'web_auth_domain' key and invalid value"
          end
        end
      end

      unless verify_tx_signed_by(tx_envelope: envelope, keypair: server)
        raise InvalidSep10ChallengeError, "The transaction is not signed by the server"
      end

      time_bounds = transaction.time_bounds
      now = Time.now.to_i

      if time_bounds.blank? || !now.between?(time_bounds.min_time, time_bounds.max_time)
        raise InvalidSep10ChallengeError, "The transaction has expired"
      end

      # Mirror the return type of the other SDK's and return a string
      client_kp = Stellar::KeyPair.from_public_key(client_account_id.ed25519!)

      [envelope, client_kp.address]
    end

    # Verifies that for a SEP 10 challenge transaction all signatures on the transaction
    # are accounted for and that the signatures meet a threshold on an account. A
    # transaction is verified if it is signed by the server account, and all other
    # signatures match a signer that has been provided as an argument, and those
    # signatures meet a threshold on the account.
    #
    # @param server [Stellar::KeyPair] keypair for server's account.
    # @param challenge_xdr [String] SEP0010 challenge transaction in base64.
    # @param signers [{String => Integer}] The signers of client account.
    # @param threshold [Integer] The medThreshold on the client account.
    #
    # @raise InvalidSep10ChallengeError if the transaction has unrecognized signatures (only server's
    #   signing key and keypairs found in the `signing` argument are recognized) or total weight of
    #   the signers does not meet the `threshold`
    #
    # @return [<String>] subset of input signers who have signed `challenge_xdr`
    def self.verify_challenge_tx_threshold(server:, challenge_xdr:, signers:, threshold:)
      signers_found = verify_challenge_tx_signers(
        server: server, challenge_xdr: challenge_xdr, signers: signers.keys
      )

      total_weight = signers.values_at(*signers_found).sum

      if total_weight < threshold
        raise InvalidSep10ChallengeError, "signers with weight #{total_weight} do not meet threshold #{threshold}."
      end

      signers_found
    end

    # Verifies that for a SEP 10 challenge transaction all signatures on the transaction are accounted for.
    #
    # A transaction is verified if it is signed by the server account, and all other signatures match a signer
    # that has been provided as an argument. Additional signers can be provided that do not have a signature,
    # but all signatures must be matched to a signer for verification to succeed.
    #
    # If verification succeeds a list of signers that were found is returned, excluding the server account ID.
    #
    # @param server [Stellar::Keypair]  server's signing key
    # @param challenge_xdr [String] SEP0010 transaction challenge transaction in base64.
    # @param signers [<String>] The signers of client account.
    #
    # @raise InvalidSep10ChallengeError one or more signatures in the transaction are not identifiable
    #   as the server account or one of the signers provided in the arguments
    #
    # @return [<String>] subset of input signers who have signed `challenge_xdr`
    def self.verify_challenge_tx_signers(server:, challenge_xdr:, signers:)
      raise InvalidSep10ChallengeError, "no signers provided" if signers.empty?

      te, _ = read_challenge_tx(server: server, challenge_xdr: challenge_xdr)

      # ignore non-G signers and server's own address
      client_signers = signers.select { |s| s =~ /G[A-Z0-9]{55}/ && s != server.address }.to_set
      raise InvalidSep10ChallengeError, "at least one regular signer must be provided" if client_signers.empty?

      # verify all signatures in one pass
      client_signers.add(server.address)
      signers_found = verify_tx_signatures(tx_envelope: te, signers: client_signers)

      # ensure server signed transaction and remove it
      unless signers_found.delete?(server.address)
        raise InvalidSep10ChallengeError, "Transaction not signed by server: #{server.address}"
      end

      # Confirm we matched signatures to the client signers.
      if signers_found.empty?
        raise InvalidSep10ChallengeError, "Transaction not signed by any client signer."
      end

      # Confirm all signatures were consumed by a signer.
      if signers_found.size != te.signatures.length - 1
        raise InvalidSep10ChallengeError, "Transaction has unrecognized signatures."
      end

      signers_found
    end

    # Verifies every signer passed matches a signature on the transaction exactly once,
    # returning a list of unique signers that were found to have signed the transaction.
    #
    # @param tx_envelope [Stellar::TransactionEnvelope] SEP0010 transaction challenge transaction envelope.
    # @param signers [<String>] The signers of client account.
    #
    # @return [Set<Stellar::KeyPair>]
    def self.verify_tx_signatures(tx_envelope:, signers:)
      signatures = tx_envelope.signatures
      if signatures.empty?
        raise InvalidSep10ChallengeError, "Transaction has no signatures."
      end

      tx_hash = tx_envelope.tx.hash
      to_keypair = Stellar::DSL.method(:KeyPair)
      keys_by_hint = signers.map(&to_keypair).index_by(&:signature_hint)

      tx_envelope.signatures.each.with_object(Set.new) do |sig, result|
        key = keys_by_hint.delete(sig.hint)
        result.add(key.address) if key&.verify(sig.signature, tx_hash)
      end
    end

    # Verifies if a Stellar::TransactionEnvelope was signed by the given Stellar::KeyPair
    #
    # @example
    #   Stellar::SEP10.verify_tx_signed_by(tx_envelope: envelope, keypair: keypair)
    #
    # @param tx_envelope [Stellar::TransactionEnvelope]
    # @param keypair [Stellar::KeyPair]
    #
    # @return [Boolean]
    def self.verify_tx_signed_by(tx_envelope:, keypair:)
      tx_hash = tx_envelope.tx.hash
      tx_envelope.signatures.any? do |sig|
        next if sig.hint != keypair.signature_hint

        keypair.verify(sig.signature, tx_hash)
      end
    end
  end
end

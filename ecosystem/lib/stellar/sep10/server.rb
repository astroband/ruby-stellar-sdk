module Stellar
  module Ecosystem
    module SEP10
      class Server
        def initialize(keypair:)
          @keypair = keypair
        end

        def build_challenge(client:, domain: nil, timeout: 300, **options)
          if domain.blank? && options.key?(:anchor_name)
            ActiveSupport::Deprecation.new("next release", "stellar-sdk").warn <<~MSG
              SEP-10 v2.0.0 requires usage of service home domain instead of anchor name in the challenge transaction.
              Please update your implementation to use `Stellar::SEP10.build_challenge_tx(..., home_domain: 'example.com')`.
              Using `anchor_name` parameter makes your service incompatible with SEP10-2.0 clients, support for this parameter
              is deprecated and will be removed in the next major release of stellar-base.
            MSG
            domain = options[:anchor_name]
          end

          Challenge.new(
            server: @keypair,
            client: client,
            domain: domain,
            timeout: timeout,
            **options
          )
        end

        # Verifies that for a SEP 10 challenge transaction all signatures on the transaction are accounted for.
        #
        # A transaction is verified if it is signed by the server account, and all other signatures match a signer
        # that has been provided as an argument. Additional signers can be provided that do not have a signature,
        # but all signatures must be matched to a signer for verification to succeed.
        #
        # If verification succeeds a list of signers that were found is returned, excluding the server account ID.
        #
        # @param challenge_xdr [String] SEP0010 transaction challenge transaction in base64.
        # @param signers [<String>] The signers of client account.
        #
        # @raise InvalidChallengeError one or more signatures in the transaction are not identifiable
        #   as the server account or one of the signers provided in the arguments
        #
        # @return [<String>] subset of input signers who have signed `challenge_xdr`
        def verify_challenge_tx_signers!(challenge_xdr:, signers:)
          raise ArgumentError, "no signers provided" if signers.empty?

          # ignore non-G signers and server's own address
          client_signers = signers.select { |s| s =~ /G[A-Z0-9]{55}/ && s != keypair.address }.to_set
          raise ArgumentError, "at least one regular signer must be provided" if client_signers.empty?

          challenge = Challenge.read_xdr(challenge_xdr, server: keypair)
          challenge.validate!

          client_signers.add(challenge.client_domain_account_address) if challenge.client_domain_account_address.present?

          # verify all signatures in one pass
          client_signers.add(keypair.address)
          tx_envelope = challenge.to_envelope
          signers_found = verify_tx_signatures!(tx_envelope: tx_envelope, signers: client_signers)

          # ensure server signed transaction and remove it
          unless signers_found.delete?(keypair.address)
            raise InvalidChallengeError, "Transaction not signed by server: #{keypair}"
          end

          # Confirm we matched signatures to the client signers.
          if signers_found.empty?
            raise InvalidChallengeError, "Transaction not signed by any client signer."
          end

          # Confirm all signatures were consumed by a signer.
          if signers_found.size != tx_envelope.signatures.length - 1
            raise InvalidChallengeError, "Transaction has unrecognized signatures."
          end

          if challenge.client_domain_account_address.present? && !signers_found.include?(challenge.client_domain_account_address)
            raise InvalidChallengeError, "Transaction not signed by client domain account."
          end

          signers_found
        end

        # Verifies that for a SEP 10 challenge transaction all signatures on the transaction
        # are accounted for and that the signatures meet a threshold on an account. A
        # transaction is verified if it is signed by the server account, and all other
        # signatures match a signer that has been provided as an argument, and those
        # signatures meet a threshold on the account.
        #
        # @param challenge_xdr [String] SEP0010 challenge transaction in base64.
        # @param signers [{String => Integer}] The signers of client account.
        # @param threshold [Integer] The medThreshold on the client account.
        #
        # @raise InvalidChallengeError if the transaction has unrecognized signatures (only server's
        #   signing key and keypairs found in the `signing` argument are recognized) or total weight of
        #   the signers does not meet the `threshold`
        #
        # @return [<String>] subset of input signers who have signed `challenge_xdr`
        def verify_challenge_tx_threshold!(challenge_xdr:, signers:, threshold:)
          signers_found = verify_challenge_tx_signers!(challenge_xdr: challenge_xdr, signers: signers.keys)

          total_weight = signers.values_at(*signers_found).sum

          if total_weight < threshold
            raise InvalidChallengeError, "signers with weight #{total_weight} do not meet threshold #{threshold}."
          end

          signers_found
        end

        private

        attr_reader :keypair

        # Verifies every signer passed matches a signature on the transaction exactly once,
        # returning a list of unique signers that were found to have signed the transaction.
        #
        # @param tx_envelope [Stellar::TransactionEnvelope] SEP0010 transaction challenge transaction envelope.
        # @param signers [<String>] The signers of client account.
        #
        # @return [Set<Stellar::KeyPair>]
        def verify_tx_signatures!(tx_envelope:, signers:)
          signatures = tx_envelope.signatures
          if signatures.empty?
            raise InvalidChallengeError, "Transaction has no signatures."
          end

          tx_hash = tx_envelope.tx.hash
          to_keypair = Stellar::DSL.method(:KeyPair)
          keys_by_hint = signers.map(&to_keypair).index_by(&:signature_hint)

          signatures.each_with_object(Set.new) do |sig, result|
            key = keys_by_hint.delete(sig.hint)
            result.add(key.address) if key&.verify(sig.signature, tx_hash)
          end
        end
      end
    end
  end
end

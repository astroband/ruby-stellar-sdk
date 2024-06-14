module Stellar
  module Ecosystem
    module SEP10
      class InvalidChallengeError < StandardError; end

      class Challenge
        # We use a small grace period for the challenge transaction time bounds
        # to compensate possible clock drift on client's machine
        GRACE_PERIOD = 5.minutes

        def self.build(server:, client:, domain: nil, timeout: 300, **options)
          tx = ChallengeTxBuilder.build(
            server: server,
            client: client,
            domain: domain,
            timeout: timeout,
            **options
          )

          new(envelope: tx.to_envelope(server), server: server)
        end

        def self.read_xdr(xdr, server:)
          envelope = Stellar::TransactionEnvelope.from_xdr(xdr, "base64")
          new(envelope: envelope, server: server)
        end

        def initialize(envelope:, server:)
          @envelope = envelope
          @tx = envelope.tx
          @server = server
        end

        def to_xdr
          @envelope.to_xdr(:base64)
        end

        def to_envelope
          @envelope.clone
        end

        def validate!(**options)
          validate_tx!
          validate_operations!(options)

          raise InvalidChallengeError, "The transaction is not signed by the server" unless @envelope.signed_by?(server)
        end

        def client
          @client ||= begin
            auth_op = tx.operations&.first
            auth_op && Stellar::KeyPair.from_public_key(auth_op.source_account.ed25519!)
          end
        end

        def client_domain_account_address
          @client_domain_account_address = begin
            client_domain_account_op = tx.operations.find { |op| op.body.value.data_name == "client_domain" }
            client_domain_account_op && Util::StrKey.encode_muxed_account(client_domain_account_op.source_account)
          end
        end

        def verify_tx_signers(signers = [])
          raise ArgumentError, "no signers provided" if signers.empty?

          # ignore non-G signers and server's own address
          client_signers = signers.select { |s| s =~ /G[A-Z0-9]{55}/ && s != server.address }.to_set
          raise ArgumentError, "at least one regular signer must be provided" if client_signers.empty?

          raise InvalidChallengeError, "transaction has no signatures." if envelope.signatures.empty?

          client_signers.add(client_domain_account_address) if client_domain_account_address.present?

          # verify all signatures in one pass
          client_signers.add(server.address)
          signers_found = verify_tx_signatures(tx_envelope: te, signers: client_signers)

          # ensure server signed transaction and remove it
          unless signers_found.delete?(server.address)
            raise InvalidChallengeError, "Transaction not signed by server: #{server.address}"
          end

          # Confirm we matched signatures to the client signers.
          if signers_found.empty?
            raise InvalidChallengeError, "Transaction not signed by any client signer."
          end

          # Confirm all signatures were consumed by a signer.
          if signers_found.size != envelope.signatures.length - 1
            raise InvalidSep10ChallengeError, "Transaction has unrecognized signatures."
          end

          if client_domain_account_address.present? && !signers_found.include?(client_domain_account_address)
            raise InvalidSep10ChallengeError, "Transaction not signed by client domain account."
          end

          signers_found
        end

        private

        attr_reader :tx, :server

        def validate_tx!
          if tx.seq_num != 0
            raise InvalidChallengeError, "The transaction sequence number should be zero"
          end

          if tx.source_account != server.muxed_account
            raise InvalidChallengeError, "The transaction source account is not equal to the server's account"
          end

          if tx.operations.size < 1
            raise InvalidChallengeError, "The transaction should contain at least one operation"
          end

          time_bounds = tx.cond.time_bounds
          now = Time.now.to_i

          if time_bounds.blank? || !now.between?(time_bounds.min_time - GRACE_PERIOD, time_bounds.max_time + GRACE_PERIOD)
            raise InvalidChallengeError, "The transaction has expired"
          end
        end

        def validate_operations!(**options)
          auth_op, *rest_ops = tx.operations
          client_account_id = auth_op.source_account

          auth_op_body = auth_op.body.value

          if client_account_id.blank?
            raise InvalidChallengeError, "The transaction's operation should contain a source account"
          end

          if auth_op.body.arm != :manage_data_op
            raise InvalidChallengeError, "The transaction's first operation should be manageData"
          end

          if options.key?(:domain) && auth_op_body.data_name != "#{options[:domain]} auth"
            raise InvalidChallengeError, "The transaction's operation data name is invalid"
          end

          if auth_op_body.data_value.unpack1("m").size != 48
            raise InvalidChallengeError, "The transaction's operation value should be a 64 bytes base64 random string"
          end

          rest_ops.each do |op|
            body = op.body
            op_params = body.value

            if body.arm != :manage_data_op
              raise InvalidChallengeError, "The transaction has operations that are not of type 'manageData'"
            elsif op.source_account != server.muxed_account && op_params.data_name != "client_domain"
              raise InvalidChallengeError, "The transaction has operations that are unrecognized"
            elsif op_params.data_name == "web_auth_domain" && options.key?(:auth_domain) && op_params.data_value != options[:auth_domain]
              raise InvalidChallengeError, "The transaction has 'manageData' operation with 'web_auth_domain' key and invalid value"
            end
          end
        end
      end
    end
  end
end

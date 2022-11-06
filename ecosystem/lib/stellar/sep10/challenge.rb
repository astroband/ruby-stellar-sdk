module Stellar
  module Ecosystem
    module SEP10
      class Challenge
        def self.build(server:, client:, domain: nil, timeout: 300, **options)
          tx = ChallengeTxBuilder.build(
            server: server,
            client: client,
            domain: domain,
            timeout: timeout,
            options
          )

          new(tx: tx)
        end

        def self.read_xdr(xdr)
          envelope = Stellar::TransactionEnvelope.from_xdr(xdr, "base64")
          new(tx: envelope.tx)
        end

        def to_xdr
          tx.to_envelope(server).to_xdr(:base64)
        end

        def validate!(server_keypair:, **options)
          validate_tx!(server_keypair: server_keypair)
          validate_operations!(options)
        end

        private

        attr_reader :tx

        def validate_tx!(server_keypair:)
          if tx.seq_num != 0
            raise InvalidSep10ChallengeError, "The transaction sequence number should be zero"
          end

          if tx.source_account != server_keypair.muxed_account
            raise InvalidSep10ChallengeError, "The transaction source account is not equal to the server's account"
          end

          if tx.operations.size < 1
            raise InvalidSep10ChallengeError, "The transaction should contain at least one operation"
          end
        end

        def validate_operations!(options)
          auth_op, *rest_ops = tx.operations
          client_account_id = auth_op.source_account

          auth_op_body = auth_op.body.value

          if client_account_id.blank?
            raise InvalidSep10ChallengeError, "The transaction's operation should contain a source account"
          end

          if auth_op.body.arm != :manage_data_op
            raise InvalidSep10ChallengeError, "The transaction's first operation should be manageData"
          end

          if options.key?(:domain) && auth_op_body.data_name != "#{options[:domain]} auth"
            raise InvalidSep10ChallengeError, "The transaction's operation data name is invalid"
          end

          if auth_op_body.data_value.unpack1("m").size != 48
            raise InvalidSep10ChallengeError, "The transaction's operation value should be a 64 bytes base64 random string"
          end

          rest_ops.each do |op|
            body = op.body
            op_params = body.value

            if body.arm != :manage_data_op
              raise InvalidSep10ChallengeError, "The transaction has operations that are not of type 'manageData'"
            elsif op.source_account != server_keypair.muxed_account && op_params.data_name != "client_domain"
              raise InvalidSep10ChallengeError, "The transaction has operations that are unrecognized"
            elsif op_params.data_name == "web_auth_domain" && options.key?(:auth_domain) && op_params.data_value != options[:auth_domain]
              raise InvalidSep10ChallengeError, "The transaction has 'manageData' operation with 'web_auth_domain' key and invalid value"
            end
          end
        end
      end
    end
  end
end

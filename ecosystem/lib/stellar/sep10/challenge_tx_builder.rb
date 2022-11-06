module Stellar
  module Ecosystem
    module SEP10
      class ChallengeTxBuilder
        def self.build(server:, client:, domain: nil, timeout: 300, **options)
          new(server: server, client: client, domain: domain, timeout: timeout, options).build
        end

        def initialize(server:, client:, domain: nil, timeout: 300, **options)
          @server = server
          @client = client
          @timeout = timeout
          @domain = domain
          @options = options
        end

        def build
          tb = Stellar::TransactionBuilder.new(
            source_account: server,
            sequence_number: 0,
            time_bounds: time_bounds
          )

          tb.add_operation(main_operation)
          tb.add_operation(auth_domain_operation) if options.key?(:auth_domain)

          if options[:client_domain].present?
            if options[:client_domain_account].blank?
              raise "`client_domain_account` is required, if `client_domain` is provided"
            end

            tb.add_operation(client_domain_operation)
          end

          tb.build
        end

        private

        attr_reader :server, :client, :timeout, :domain, :options, :tx

        def time_bounds
          @time_bounds ||= begin
            now = Time.now.to_i
            Stellar::TimeBounds.new(
              min_time: now,
              max_time: now + timeout
            )
         end
        end

        def main_operation
          Stellar::Operation.manage_data(
            name: "#{domain} auth",
            value: SecureRandom.base64(48),
            source_account: client
          )
        end

        def auth_domain_operation
          Stellar::Operation.manage_data(
            name: "web_auth_domain",
            value: options[:auth_domain],
            source_account: server
          )
        end

        def client_domain_operation
          Stellar::Operation.manage_data(
            name: "client_domain",
            value: options[:client_domain],
            source_account: options[:client_domain_account]
          )
        end
      end
    end
  end
end

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
            options
          )
        end
      end
    end
  end

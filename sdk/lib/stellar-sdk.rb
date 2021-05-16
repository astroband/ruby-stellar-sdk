require "stellar-base"
require_relative "stellar/account"

Stellar::SdkDeprecation = ActiveSupport::Deprecation.new("next release", "stellar-sdk")
require_relative "stellar/compat"

module Stellar
  module SDK
    VERSION = ::Stellar::VERSION
  end

  autoload :Account
  autoload :Amount
  autoload :Client
  autoload :Federation
  autoload :SEP10

  module Horizon
    extend ActiveSupport::Autoload

    autoload :Problem
    autoload :Result
  end

  autoload :TransactionPage
end

require "stellar-base"

module Stellar
  module Horizon
    extend ActiveSupport::Autoload

    VERSION = ::Stellar::VERSION

    autoload :Client
    autoload :TransactionPage
  end
end

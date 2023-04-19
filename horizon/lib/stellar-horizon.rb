require "stellar-base"

module Stellar
  module Horizon
    extend ActiveSupport::Autoload

    VERSION = ::Stellar::VERSION

    autoload :Client
    autoload :Problem
    autoload :ResourcePage
    autoload :ClaimableBalancePage
  end
end

require "stellar-sdk"

module Stellar
  module Horizon
    VERSION = ::Stellar::VERSION

    autoload :Client, "#{__dir__}/stellar/horizon/client.rb"
  end
end

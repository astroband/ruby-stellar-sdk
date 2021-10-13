require "stellar-base"
require "stellar-horizon"

module Stellar
  module SDK
    VERSION = ::Stellar::VERSION
  end
  Client = Horizon::Client

  autoload :Amount
  autoload :Federation
  autoload :SEP10
end

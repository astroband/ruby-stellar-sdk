require "stellar-sdk"
require_relative "stellar-horizon/version"

module StellarHorizon
  autoload :Client, "#{__dir__}/stellar-horizon/client.rb"
end

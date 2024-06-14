# frozen_string_literal: true

require "stellar-base"

module Stellar
  module Ecosystem
    VERSION = ::Stellar::VERSION
  end
end

require_relative "./stellar/sep10/challenge"
require_relative "./stellar/sep10/challenge_tx_builder"
require_relative "./stellar/sep10/server"

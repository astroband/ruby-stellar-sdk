require "stellar-base"
require_relative "./stellar/version"

module Stellar
  autoload :Account
  autoload :Amount
  autoload :Client
  autoload :SEP10

  module Horizon
    extend ActiveSupport::Autoload

    autoload :Problem
    autoload :Result
  end

  autoload :TransactionPage
end

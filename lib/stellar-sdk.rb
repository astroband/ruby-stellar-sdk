require 'stellar-base'
require 'contracts'

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

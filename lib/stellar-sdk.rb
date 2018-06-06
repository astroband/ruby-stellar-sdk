require 'stellar-base'
require 'contracts'

module Stellar

  autoload :Account
  autoload :AccountInfo
  autoload :Amount
  autoload :Client

  module Horizon
    extend ActiveSupport::Autoload

    autoload :Problem
    autoload :Result
  end

  autoload :AssetPage
  autoload :TransactionPage
end

require 'stellar-base'
require 'contracts'


module Stellar
  autoload :Account, './lib/stellar/account'
  autoload :AccountInfo
  autoload :Amount, './lib/stellar/amount'
  autoload :Client, './lib/stellar/client'

  module Horizon
    extend ActiveSupport::Autoload

    autoload :Problem, './lib/horizon/problem'
    autoload :Result
  end

  autoload :TransactionPage, './lib/stellar/transaction_page'
end

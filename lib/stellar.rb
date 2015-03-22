require 'stellar-core'
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

end

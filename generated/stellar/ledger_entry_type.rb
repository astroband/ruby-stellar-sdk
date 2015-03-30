# Automatically generated on 2015-03-30T09:46:31-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class LedgerEntryType < XDR::Enum
    member :account,   0
    member :trustline, 1
    member :offer,     2

    seal
  end
end

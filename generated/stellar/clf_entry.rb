# Automatically generated from xdr/Stellar-ledger.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class CLFEntry < XDR::Union
    switch_on CLFType, :type
                       
    switch :liveentry, :live_entry
    switch :deadentry, :dead_entry
                           
    attribute :live_entry, LedgerEntry
    attribute :dead_entry, LedgerKey
  end
end

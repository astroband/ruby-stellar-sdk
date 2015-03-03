# Automatically generated from xdr/Stellar-ledger-entries.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class KeyValue < XDR::Struct
    attribute :key,   Uint32
    attribute :value, XDR::VarOpaque[64]
  end
end

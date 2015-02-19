# Automatically generated from xdr/Stellar-ledger.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  class CLFBucketHeader < XDR::Struct

                             
    attribute :ledger_seq,   Uint64
    attribute :ledger_count, Uint32
    attribute :hash,         Hash
  end
end

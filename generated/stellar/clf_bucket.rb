# Automatically generated from xdr/Stellar-ledger.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  class CLFBucket < XDR::Struct

                        
    attribute :header,  CLFBucketHeader
    attribute :entries, XDR::VarArray[CLFEntry]
  end
end

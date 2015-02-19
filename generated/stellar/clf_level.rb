# Automatically generated from xdr/Stellar-ledger.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  class CLFLevel < XDR::Struct

                     
    attribute :curr, CLFBucketHeader
    attribute :snap, CLFBucketHeader
  end
end

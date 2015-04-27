# Automatically generated on 2015-04-26T19:13:29-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionMeta
#   {
#       BucketEntry entries<>;
#   };
#
# ===========================================================================
module Stellar
  class TransactionMeta < XDR::Struct
    attribute :entries, XDR::VarArray[BucketEntry]
  end
end

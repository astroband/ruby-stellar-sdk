# Automatically generated on 2015-05-12T09:08:23-07:00
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

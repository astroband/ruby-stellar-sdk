# Automatically generated on 2015-03-31T14:32:44-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionResultSet
#   {
#       TransactionResultPair results<5000>;
#   };
#
# ===========================================================================
module Stellar
  class TransactionResultSet < XDR::Struct
    attribute :results, XDR::VarArray[TransactionResultPair, 5000]
  end
end

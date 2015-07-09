# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionResultSet
#   {
#       TransactionResultPair results<MAX_TX_PER_LEDGER>;
#   };
#
# ===========================================================================
module Stellar
  class TransactionResultSet < XDR::Struct
    attribute :results, XDR::VarArray[TransactionResultPair, MAX_TX_PER_LEDGER]
  end
end

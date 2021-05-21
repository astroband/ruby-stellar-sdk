# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionResultSet
#   {
#       TransactionResultPair results<>;
#   };
#
# ===========================================================================
module StellarProtocol
  class TransactionResultSet < XDR::Struct
    attribute :results, XDR::VarArray[TransactionResultPair]
  end
end

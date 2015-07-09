# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TransactionEnvelope
#   {
#       Transaction tx;
#       DecoratedSignature signatures<20>;
#   };
#
# ===========================================================================
module Stellar
  class TransactionEnvelope < XDR::Struct
    attribute :tx,         Transaction
    attribute :signatures, XDR::VarArray[DecoratedSignature, 20]
  end
end

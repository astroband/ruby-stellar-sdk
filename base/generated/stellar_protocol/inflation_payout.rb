# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct InflationPayout // or use PaymentResultAtom to limit types?
#   {
#       AccountID destination;
#       int64 amount;
#   };
#
# ===========================================================================
module StellarProtocol
  class InflationPayout < XDR::Struct
    attribute :destination, AccountID
    attribute :amount,      Int64
  end
end

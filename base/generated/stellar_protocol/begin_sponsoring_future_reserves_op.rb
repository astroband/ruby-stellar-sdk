# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct BeginSponsoringFutureReservesOp
#   {
#       AccountID sponsoredID;
#   };
#
# ===========================================================================
module StellarProtocol
  class BeginSponsoringFutureReservesOp < XDR::Struct
    attribute :sponsored_id, AccountID
  end
end

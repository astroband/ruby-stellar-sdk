# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           ClaimAtom offers<>;
#           SimplePaymentResult last;
#       }
#
# ===========================================================================
module Stellar
  class PathPaymentStrictReceiveResult
    class Success < XDR::Struct
      attribute :offers, XDR::VarArray[ClaimAtom]
      attribute :last,   SimplePaymentResult
    end
  end
end

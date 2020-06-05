# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union InflationResult switch (InflationResultCode code)
#   {
#   case INFLATION_SUCCESS:
#       InflationPayout payouts<>;
#   default:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class InflationResult < XDR::Union
    switch_on InflationResultCode, :code

    switch :inflation_success, :payouts
    switch :default

    attribute :payouts, XDR::VarArray[InflationPayout]
  end
end

# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union InflationResult switch (InflationResultCode code)
#   {
#   case INFLATION_SUCCESS:
#       InflationPayout payouts<>;
#   case INFLATION_NOT_TIME:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class InflationResult < XDR::Union
    switch_on InflationResultCode, :code

    switch :inflation_success, :payouts
    switch :inflation_not_time

    attribute :payouts, XDR::VarArray[InflationPayout]
  end
end

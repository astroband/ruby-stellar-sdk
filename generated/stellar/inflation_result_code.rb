# Automatically generated on 2015-04-26T19:13:29-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum InflationResultCode
#   {
#       // codes considered as "success" for the operation
#       INFLATION_SUCCESS = 0,
#       // codes considered as "failure" for the operation
#       INFLATION_NOT_TIME = -1
#   };
#
# ===========================================================================
module Stellar
  class InflationResultCode < XDR::Enum
    member :inflation_success,  0
    member :inflation_not_time, -1

    seal
  end
end

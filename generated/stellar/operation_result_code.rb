# Automatically generated on 2015-05-13T15:00:04-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum OperationResultCode
#   {
#       opINNER = 0, // inner object result is valid
#   
#       opBAD_AUTH = -1,  // not enough signatures to perform operation
#       opNO_ACCOUNT = -2 // source account was not found
#   };
#
# ===========================================================================
module Stellar
  class OperationResultCode < XDR::Enum
    member :op_inner,      0
    member :op_bad_auth,   -1
    member :op_no_account, -2

    seal
  end
end

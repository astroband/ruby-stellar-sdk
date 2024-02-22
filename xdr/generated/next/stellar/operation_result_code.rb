# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum OperationResultCode
#   {
#       opINNER = 0, // inner object result is valid
#   
#       opBAD_AUTH = -1,            // too few valid signatures / wrong network
#       opNO_ACCOUNT = -2,          // source account was not found
#       opNOT_SUPPORTED = -3,       // operation not supported at this time
#       opTOO_MANY_SUBENTRIES = -4, // max number of subentries already reached
#       opEXCEEDED_WORK_LIMIT = -5, // operation did too much work
#       opTOO_MANY_SPONSORING = -6  // account is sponsoring too many entries
#   };
#
# ===========================================================================
module Stellar
  class OperationResultCode < XDR::Enum
    member :op_inner,               0
    member :op_bad_auth,            -1
    member :op_no_account,          -2
    member :op_not_supported,       -3
    member :op_too_many_subentries, -4
    member :op_exceeded_work_limit, -5
    member :op_too_many_sponsoring, -6

    seal
  end
end

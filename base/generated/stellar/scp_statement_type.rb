# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SCPStatementType
#   {
#       SCP_ST_PREPARE = 0,
#       SCP_ST_CONFIRM = 1,
#       SCP_ST_EXTERNALIZE = 2,
#       SCP_ST_NOMINATE = 3
#   };
#
# ===========================================================================
module Stellar
  class SCPStatementType < XDR::Enum
    member :scp_st_prepare,     0
    member :scp_st_confirm,     1
    member :scp_st_externalize, 2
    member :scp_st_nominate,    3

    seal
  end
end

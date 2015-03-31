# Automatically generated on 2015-03-31T14:32:44-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum SCPStatementType
#   {
#       PREPARING = 0,
#       PREPARED = 1,
#       COMMITTING = 2,
#       COMMITTED = 3
#   };
#
# ===========================================================================
module Stellar
  class SCPStatementType < XDR::Enum
    member :preparing,  0
    member :prepared,   1
    member :committing, 2
    member :committed,  3

    seal
  end
end

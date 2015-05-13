# Automatically generated on 2015-05-13T15:00:04-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum MemoType
#   {
#       MEMO_NONE = 0,
#       MEMO_TEXT = 1,
#       MEMO_ID = 2,
#       MEMO_HASH = 3,
#       MEMO_RETURN = 4
#   };
#
# ===========================================================================
module Stellar
  class MemoType < XDR::Enum
    member :memo_none,   0
    member :memo_text,   1
    member :memo_id,     2
    member :memo_hash,   3
    member :memo_return, 4

    seal
  end
end

# Automatically generated on 2015-05-07T07:56:23-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum MemoType
#   {
#       MEMO_TYPE_NONE = 0,
#       MEMO_TYPE_TEXT = 1,
#   	MEMO_TYPE_ID = 2,
#       MEMO_TYPE_HASH = 3,
#   	MEMO_TYPE_RETURN =4
#   };
#
# ===========================================================================
module Stellar
  class MemoType < XDR::Enum
    member :memo_type_none,   0
    member :memo_type_text,   1
    member :memo_type_id,     2
    member :memo_type_hash,   3
    member :memo_type_return, 4

    seal
  end
end

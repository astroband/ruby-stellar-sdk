# Automatically generated on 2015-05-12T09:08:23-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   union Memo switch (MemoType type)
#   {
#   case MEMO_TYPE_NONE:
#       void;
#   case MEMO_TYPE_TEXT:
#       string text<28>;
#   case MEMO_TYPE_ID:
#       uint64 id;
#   case MEMO_TYPE_HASH:
#       Hash hash; // the hash of what to pull from the content server
#   case MEMO_TYPE_RETURN:
#       Hash retHash; // the hash of the tx you are rejecting
#   };
#
# ===========================================================================
module Stellar
  class Memo < XDR::Union
    switch_on MemoType, :type

    switch :memo_type_none
    switch :memo_type_text,   :text
    switch :memo_type_id,     :id
    switch :memo_type_hash,   :hash
    switch :memo_type_return, :ret_hash

    attribute :text,     XDR::String[28]
    attribute :id,       Uint64
    attribute :hash,     Hash
    attribute :ret_hash, Hash
  end
end

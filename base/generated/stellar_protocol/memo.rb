# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union Memo switch (MemoType type)
#   {
#   case MEMO_NONE:
#       void;
#   case MEMO_TEXT:
#       string text<28>;
#   case MEMO_ID:
#       uint64 id;
#   case MEMO_HASH:
#       Hash hash; // the hash of what to pull from the content server
#   case MEMO_RETURN:
#       Hash retHash; // the hash of the tx you are rejecting
#   };
#
# ===========================================================================
module StellarProtocol
  class Memo < XDR::Union
    switch_on MemoType, :type

    switch :memo_none
    switch :memo_text,   :text
    switch :memo_id,     :id
    switch :memo_hash,   :hash
    switch :memo_return, :ret_hash

    attribute :text,     XDR::String[28]
    attribute :id,       Uint64
    attribute :hash,     Hash
    attribute :ret_hash, Hash
  end
end

# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct BumpSequenceOp
#   {
#       SequenceNumber bumpTo;
#   };
#
# ===========================================================================
module Stellar
  class BumpSequenceOp < XDR::Struct
    attribute :bump_to, SequenceNumber
  end
end

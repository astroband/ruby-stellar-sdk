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
module StellarProtocol
  class BumpSequenceOp < XDR::Struct
    attribute :bump_to, SequenceNumber
  end
end

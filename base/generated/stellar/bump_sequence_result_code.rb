# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum BumpSequenceResultCode
#   {
#       // codes considered as "success" for the operation
#       BUMP_SEQUENCE_SUCCESS = 0,
#       // codes considered as "failure" for the operation
#       BUMP_SEQUENCE_BAD_SEQ = -1 // `bumpTo` is not within bounds
#   };
#
# ===========================================================================
module Stellar
  class BumpSequenceResultCode < XDR::Enum
    member :bump_sequence_success, 0
    member :bump_sequence_bad_seq, -1

    seal
  end
end

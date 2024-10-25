# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union BumpSequenceResult switch (BumpSequenceResultCode code)
#   {
#   case BUMP_SEQUENCE_SUCCESS:
#       void;
#   case BUMP_SEQUENCE_BAD_SEQ:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class BumpSequenceResult < XDR::Union
    switch_on BumpSequenceResultCode, :code

    switch :bump_sequence_success
    switch :bump_sequence_bad_seq

  end
end

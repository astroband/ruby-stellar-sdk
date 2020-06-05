# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union BumpSequenceResult switch (BumpSequenceResultCode code)
#   {
#   case BUMP_SEQUENCE_SUCCESS:
#       void;
#   default:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class BumpSequenceResult < XDR::Union
    switch_on BumpSequenceResultCode, :code

    switch :bump_sequence_success
    switch :default

  end
end

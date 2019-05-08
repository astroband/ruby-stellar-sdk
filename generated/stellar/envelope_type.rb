# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum EnvelopeType
#   {
#       ENVELOPE_TYPE_SCP = 1,
#       ENVELOPE_TYPE_TX = 2,
#       ENVELOPE_TYPE_AUTH = 3,
#       ENVELOPE_TYPE_SCPVALUE = 4
#   };
#
# ===========================================================================
module Stellar
  class EnvelopeType < XDR::Enum
    member :envelope_type_scp,      1
    member :envelope_type_tx,       2
    member :envelope_type_auth,     3
    member :envelope_type_scpvalue, 4

    seal
  end
end

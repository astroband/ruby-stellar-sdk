# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum EnvelopeType
#   {
#       ENVELOPE_TYPE_TX_V0 = 0,
#       ENVELOPE_TYPE_SCP = 1,
#       ENVELOPE_TYPE_TX = 2,
#       ENVELOPE_TYPE_AUTH = 3,
#       ENVELOPE_TYPE_SCPVALUE = 4,
#       ENVELOPE_TYPE_TX_FEE_BUMP = 5
#   };
#
# ===========================================================================
module Stellar
  class EnvelopeType < XDR::Enum
    member :envelope_type_tx_v0,       0
    member :envelope_type_scp,         1
    member :envelope_type_tx,          2
    member :envelope_type_auth,        3
    member :envelope_type_scpvalue,    4
    member :envelope_type_tx_fee_bump, 5

    seal
  end
end

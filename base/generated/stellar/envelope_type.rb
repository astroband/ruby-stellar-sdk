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
#       ENVELOPE_TYPE_TX_FEE_BUMP = 5,
#       ENVELOPE_TYPE_OP_ID = 6,
#       ENVELOPE_TYPE_POOL_REVOKE_OP_ID = 7,
#       ENVELOPE_TYPE_CONTRACT_ID = 8,
#       ENVELOPE_TYPE_SOROBAN_AUTHORIZATION = 9
#   };
#
# ===========================================================================
module Stellar
  class EnvelopeType < XDR::Enum
    member :envelope_type_tx_v0,                 0
    member :envelope_type_scp,                   1
    member :envelope_type_tx,                    2
    member :envelope_type_auth,                  3
    member :envelope_type_scpvalue,              4
    member :envelope_type_tx_fee_bump,           5
    member :envelope_type_op_id,                 6
    member :envelope_type_pool_revoke_op_id,     7
    member :envelope_type_contract_id,           8
    member :envelope_type_soroban_authorization, 9

    seal
  end
end

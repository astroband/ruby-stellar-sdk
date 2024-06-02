# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union HashIDPreimage switch (EnvelopeType type)
#   {
#   case ENVELOPE_TYPE_OP_ID:
#       struct
#       {
#           AccountID sourceAccount;
#           SequenceNumber seqNum;
#           uint32 opNum;
#       } operationID;
#   case ENVELOPE_TYPE_POOL_REVOKE_OP_ID:
#       struct
#       {
#           AccountID sourceAccount;
#           SequenceNumber seqNum;
#           uint32 opNum;
#           PoolID liquidityPoolID;
#           Asset asset;
#       } revokeID;
#   };
#
# ===========================================================================
module Stellar
  class HashIDPreimage < XDR::Union
    include XDR::Namespace

    autoload :OperationID
    autoload :RevokeID

    switch_on EnvelopeType, :type

    switch :envelope_type_op_id,             :operation_id
    switch :envelope_type_pool_revoke_op_id, :revoke_id

    attribute :operation_id, OperationID
    attribute :revoke_id,    RevokeID
  end
end

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
#   case ENVELOPE_TYPE_CONTRACT_ID:
#       struct
#       {
#           Hash networkID;
#           ContractIDPreimage contractIDPreimage;
#       } contractID;
#   case ENVELOPE_TYPE_SOROBAN_AUTHORIZATION:
#       struct
#       {
#           Hash networkID;
#           int64 nonce;
#           uint32 signatureExpirationLedger;
#           SorobanAuthorizedInvocation invocation;
#       } sorobanAuthorization;
#   };
#
# ===========================================================================
module Stellar
  class HashIDPreimage < XDR::Union
    include XDR::Namespace

    autoload :OperationID
    autoload :RevokeID
    autoload :ContractID
    autoload :SorobanAuthorization

    switch_on EnvelopeType, :type

    switch :envelope_type_op_id,                 :operation_id
    switch :envelope_type_pool_revoke_op_id,     :revoke_id
    switch :envelope_type_contract_id,           :contract_id
    switch :envelope_type_soroban_authorization, :soroban_authorization

    attribute :operation_id,          OperationID
    attribute :revoke_id,             RevokeID
    attribute :contract_id,           ContractID
    attribute :soroban_authorization, SorobanAuthorization
  end
end

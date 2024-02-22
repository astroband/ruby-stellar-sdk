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
#   case ENVELOPE_TYPE_CONTRACT_ID_FROM_ED25519:
#       struct
#       {
#           Hash networkID;
#           uint256 ed25519;
#           uint256 salt;
#       } ed25519ContractID;
#   case ENVELOPE_TYPE_CONTRACT_ID_FROM_CONTRACT:
#       struct
#       {
#           Hash networkID;
#           Hash contractID;
#           uint256 salt;
#       } contractID;
#   case ENVELOPE_TYPE_CONTRACT_ID_FROM_ASSET:
#       struct
#       {
#           Hash networkID;
#           Asset asset;
#       } fromAsset;
#   case ENVELOPE_TYPE_CONTRACT_ID_FROM_SOURCE_ACCOUNT:
#       struct
#       {
#           Hash networkID;
#           AccountID sourceAccount;
#           uint256 salt;
#       } sourceAccountContractID;
#   case ENVELOPE_TYPE_CREATE_CONTRACT_ARGS:
#       struct
#       {
#           Hash networkID;
#           SCContractExecutable source;
#           uint256 salt;
#       } createContractArgs;
#   case ENVELOPE_TYPE_CONTRACT_AUTH:
#       struct
#       {
#           Hash networkID;
#           uint64 nonce;
#           AuthorizedInvocation invocation;
#       } contractAuth;
#   };
#
# ===========================================================================
module Stellar
  class HashIDPreimage < XDR::Union
    include XDR::Namespace

    autoload :OperationID
    autoload :RevokeID
    autoload :Ed25519ContractID
    autoload :ContractID
    autoload :FromAsset
    autoload :SourceAccountContractID
    autoload :CreateContractArgs
    autoload :ContractAuth

    switch_on EnvelopeType, :type

    switch :envelope_type_op_id,                           :operation_id
    switch :envelope_type_pool_revoke_op_id,               :revoke_id
    switch :envelope_type_contract_id_from_ed25519,        :ed25519_contract_id
    switch :envelope_type_contract_id_from_contract,       :contract_id
    switch :envelope_type_contract_id_from_asset,          :from_asset
    switch :envelope_type_contract_id_from_source_account, :source_account_contract_id
    switch :envelope_type_create_contract_args,            :create_contract_args
    switch :envelope_type_contract_auth,                   :contract_auth

    attribute :operation_id,               OperationID
    attribute :revoke_id,                  RevokeID
    attribute :ed25519_contract_id,        Ed25519ContractID
    attribute :contract_id,                ContractID
    attribute :from_asset,                 FromAsset
    attribute :source_account_contract_id, SourceAccountContractID
    attribute :create_contract_args,       CreateContractArgs
    attribute :contract_auth,              ContractAuth
  end
end

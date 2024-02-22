# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union ContractID switch (ContractIDType type)
#   {
#   case CONTRACT_ID_FROM_SOURCE_ACCOUNT:
#       uint256 salt;
#   case CONTRACT_ID_FROM_ED25519_PUBLIC_KEY:
#       struct 
#       {
#           uint256 key;
#           Signature signature;
#           uint256 salt;
#       } fromEd25519PublicKey;
#   case CONTRACT_ID_FROM_ASSET:
#       Asset asset;
#   };
#
# ===========================================================================
module Stellar
  class ContractID < XDR::Union
    include XDR::Namespace

    autoload :FromEd25519PublicKey

    switch_on ContractIDType, :type

    switch :contract_id_from_source_account,     :salt
    switch :contract_id_from_ed25519_public_key, :from_ed25519_public_key
    switch :contract_id_from_asset,              :asset

    attribute :salt,                    Uint256
    attribute :from_ed25519_public_key, FromEd25519PublicKey
    attribute :asset,                   Asset
  end
end

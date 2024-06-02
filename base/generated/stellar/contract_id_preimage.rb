# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union ContractIDPreimage switch (ContractIDPreimageType type)
#   {
#   case CONTRACT_ID_PREIMAGE_FROM_ADDRESS:
#       struct
#       {
#           SCAddress address;
#           uint256 salt;
#       } fromAddress;
#   case CONTRACT_ID_PREIMAGE_FROM_ASSET:
#       Asset fromAsset;
#   };
#
# ===========================================================================
module Stellar
  class ContractIDPreimage < XDR::Union
    include XDR::Namespace

    autoload :FromAddress

    switch_on ContractIDPreimageType, :type

    switch :contract_id_preimage_from_address, :from_address
    switch :contract_id_preimage_from_asset,   :from_asset

    attribute :from_address, FromAddress
    attribute :from_asset,   Asset
  end
end

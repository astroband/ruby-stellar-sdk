# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct CreateContractArgs
#   {
#       ContractID contractID;
#       SCContractExecutable source;
#   };
#
# ===========================================================================
module Stellar
  class CreateContractArgs < XDR::Struct
    attribute :contract_id, ContractID
    attribute :source,      SCContractExecutable
  end
end

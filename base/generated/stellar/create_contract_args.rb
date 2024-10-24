# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct CreateContractArgs
#   {
#       ContractIDPreimage contractIDPreimage;
#       ContractExecutable executable;
#   };
#
# ===========================================================================
module Stellar
  class CreateContractArgs < XDR::Struct
    attribute :contract_id_preimage, ContractIDPreimage
    attribute :executable,           ContractExecutable
  end
end

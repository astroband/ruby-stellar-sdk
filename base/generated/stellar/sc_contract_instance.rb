# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCContractInstance {
#       ContractExecutable executable;
#       SCMap* storage;
#   };
#
# ===========================================================================
module Stellar
  class SCContractInstance < XDR::Struct
    attribute :executable, ContractExecutable
    attribute :storage,    XDR::Option[SCMap]
  end
end

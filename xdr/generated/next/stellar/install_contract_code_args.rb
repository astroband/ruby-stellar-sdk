# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct InstallContractCodeArgs
#   {
#       opaque code<SCVAL_LIMIT>;
#   };
#
# ===========================================================================
module Stellar
  class InstallContractCodeArgs < XDR::Struct
    attribute :code, XDR::VarOpaque[SCVAL_LIMIT]
  end
end

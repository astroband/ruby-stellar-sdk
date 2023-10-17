# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ContractCodeEntry {
#       ExtensionPoint ext;
#
#       Hash hash;
#       opaque code<>;
#   };
#
# ===========================================================================
module Stellar
  class ContractCodeEntry < XDR::Struct
    attribute :ext,  ExtensionPoint
    attribute :hash, Hash
    attribute :code, XDR::VarOpaque[]
  end
end

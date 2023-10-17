# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ContractCostParamEntry {
#       // use `ext` to add more terms (e.g. higher order polynomials) in the future
#       ExtensionPoint ext;
#
#       int64 constTerm;
#       int64 linearTerm;
#   };
#
# ===========================================================================
module Stellar
  class ContractCostParamEntry < XDR::Struct
    attribute :ext,         ExtensionPoint
    attribute :const_term,  Int64
    attribute :linear_term, Int64
  end
end

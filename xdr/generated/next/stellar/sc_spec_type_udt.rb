# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCSpecTypeUDT
#   {
#       string name<60>;
#   };
#
# ===========================================================================
module Stellar
  class SCSpecTypeUDT < XDR::Struct
    attribute :name, XDR::String[60]
  end
end

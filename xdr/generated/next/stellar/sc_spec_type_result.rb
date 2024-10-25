# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCSpecTypeResult
#   {
#       SCSpecTypeDef okType;
#       SCSpecTypeDef errorType;
#   };
#
# ===========================================================================
module Stellar
  class SCSpecTypeResult < XDR::Struct
    attribute :ok_type,    SCSpecTypeDef
    attribute :error_type, SCSpecTypeDef
  end
end

# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ManageDataOp
#   {
#       string64 dataName;
#       DataValue* dataValue; // set to null to clear
#   };
#
# ===========================================================================
module Stellar
  class ManageDataOp < XDR::Struct
    attribute :data_name,  String64
    attribute :data_value, XDR::Option[DataValue]
  end
end

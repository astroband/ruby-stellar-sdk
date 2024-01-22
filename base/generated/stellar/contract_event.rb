# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ContractEvent
#   {
#       // We can use this to add more fields, or because it
#       // is first, to change ContractEvent into a union.
#       ExtensionPoint ext;
#   
#       Hash* contractID;
#       ContractEventType type;
#   
#       union switch (int v)
#       {
#       case 0:
#           struct
#           {
#               SCVal topics<>;
#               SCVal data;
#           } v0;
#       }
#       body;
#   };
#
# ===========================================================================
module Stellar
  class ContractEvent < XDR::Struct
    include XDR::Namespace

    autoload :Body

    attribute :ext,         ExtensionPoint
    attribute :contract_id, XDR::Option[Hash]
    attribute :type,        ContractEventType
    attribute :body,        Body
  end
end

# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct AccountEntryExtensionV1
#   {
#       Liabilities liabilities;
#   
#       union switch (int v)
#       {
#       case 0:
#           void;
#       case 2:
#           AccountEntryExtensionV2 v2;
#       }
#       ext;
#   };
#
# ===========================================================================
module Stellar
  class AccountEntryExtensionV1 < XDR::Struct
    include XDR::Namespace

    autoload :Ext

    attribute :liabilities, Liabilities
    attribute :ext,         Ext
  end
end

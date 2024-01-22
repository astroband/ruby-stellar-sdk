# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct LedgerEntryExtensionV1
#   {
#       SponsorshipDescriptor sponsoringID;
#   
#       union switch (int v)
#       {
#       case 0:
#           void;
#       }
#       ext;
#   };
#
# ===========================================================================
module Stellar
  class LedgerEntryExtensionV1 < XDR::Struct
    include XDR::Namespace

    autoload :Ext

    attribute :sponsoring_id, SponsorshipDescriptor
    attribute :ext,           Ext
  end
end

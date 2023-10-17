# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct LedgerHeaderExtensionV1
#   {
#       uint32 flags; // LedgerHeaderFlags
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
  class LedgerHeaderExtensionV1 < XDR::Struct
    include XDR::Namespace

    autoload :Ext

    attribute :flags, Uint32
    attribute :ext,   Ext
  end
end

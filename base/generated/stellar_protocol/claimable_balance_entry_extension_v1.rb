# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ClaimableBalanceEntryExtensionV1
#   {
#       union switch (int v)
#       {
#       case 0:
#           void;
#       }
#       ext;
#   
#       uint32 flags; // see ClaimableBalanceFlags
#   };
#
# ===========================================================================
module StellarProtocol
  class ClaimableBalanceEntryExtensionV1 < XDR::Struct
    include XDR::Namespace

    autoload :Ext

    attribute :ext,   Ext
    attribute :flags, Uint32
  end
end

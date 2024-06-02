# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct BucketMetadata
#   {
#       // Indicates the protocol version used to create / merge this bucket.
#       uint32 ledgerVersion;
#   
#       // reserved for future use
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
  class BucketMetadata < XDR::Struct
    include XDR::Namespace

    autoload :Ext

    attribute :ledger_version, Uint32
    attribute :ext,            Ext
  end
end

# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct LedgerHeaderHistoryEntry
#   {
#       Hash hash;
#       LedgerHeader header;
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
  class LedgerHeaderHistoryEntry < XDR::Struct
    include XDR::Namespace

    autoload :Ext

    attribute :hash,   Hash
    attribute :header, LedgerHeader
    attribute :ext,    Ext
  end
end

# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TrustLineEntryExtensionV2
#   {
#       int32 liquidityPoolUseCount;
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
  class TrustLineEntryExtensionV2 < XDR::Struct
    include XDR::Namespace

    autoload :Ext

    attribute :liquidity_pool_use_count, Int32
    attribute :ext,                      Ext
  end
end

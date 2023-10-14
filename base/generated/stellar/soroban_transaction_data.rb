# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SorobanTransactionData
#   {
#       ExtensionPoint ext;
#       SorobanResources resources;
#       // Portion of transaction `fee` allocated to refundable fees.
#       int64 refundableFee;
#   };
#
# ===========================================================================
module Stellar
  class SorobanTransactionData < XDR::Struct
    attribute :ext,            ExtensionPoint
    attribute :resources,      SorobanResources
    attribute :refundable_fee, Int64
  end
end

# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SorobanTransactionData
#   {
#       ExtensionPoint ext;
#       SorobanResources resources;
#       // Amount of the transaction `fee` allocated to the Soroban resource fees.
#       // The fraction of `resourceFee` corresponding to `resources` specified 
#       // above is *not* refundable (i.e. fees for instructions, ledger I/O), as
#       // well as fees for the transaction size.
#       // The remaining part of the fee is refundable and the charged value is
#       // based on the actual consumption of refundable resources (events, ledger
#       // rent bumps).
#       // The `inclusionFee` used for prioritization of the transaction is defined
#       // as `tx.fee - resourceFee`.
#       int64 resourceFee;
#   };
#
# ===========================================================================
module Stellar
  class SorobanTransactionData < XDR::Struct
    attribute :ext,          ExtensionPoint
    attribute :resources,    SorobanResources
    attribute :resource_fee, Int64
  end
end

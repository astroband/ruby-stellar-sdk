# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct AccountEntryExtensionV3
#   {
#       // We can use this to add more fields, or because it is first, to
#       // change AccountEntryExtensionV3 into a union.
#       ExtensionPoint ext;
#
#       // Ledger number at which `seqNum` took on its present value.
#       uint32 seqLedger;
#
#       // Time at which `seqNum` took on its present value.
#       TimePoint seqTime;
#   };
#
# ===========================================================================
module Stellar
  class AccountEntryExtensionV3 < XDR::Struct
    attribute :ext,        ExtensionPoint
    attribute :seq_ledger, Uint32
    attribute :seq_time,   TimePoint
  end
end

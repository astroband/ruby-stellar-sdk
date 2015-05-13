# Automatically generated on 2015-05-13T15:00:04-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct TrustLineEntry
#   {
#       AccountID accountID; // account this trustline belongs to
#       Currency currency;   // currency (with issuer)
#       int64 balance;       // how much of this currency the user has.
#                            // Currency defines the unit for this;
#   
#       int64 limit;  // balance cannot be above this
#       uint32 flags; // see TrustLineFlags
#   };
#
# ===========================================================================
module Stellar
  class TrustLineEntry < XDR::Struct
    attribute :account_id, AccountID
    attribute :currency,   Currency
    attribute :balance,    Int64
    attribute :limit,      Int64
    attribute :flags,      Uint32
  end
end

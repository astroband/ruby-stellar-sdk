# Automatically generated on 2015-04-26T19:13:29-07:00
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
#       int64 limit;     // balance cannot be above this
#       bool authorized; // issuer has authorized account to hold its credit
#   };
#
# ===========================================================================
module Stellar
  class TrustLineEntry < XDR::Struct
    attribute :account_id, AccountID
    attribute :currency,   Currency
    attribute :balance,    Int64
    attribute :limit,      Int64
    attribute :authorized, XDR::Bool
  end
end

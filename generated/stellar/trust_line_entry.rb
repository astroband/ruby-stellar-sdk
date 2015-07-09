# This code was automatically generated using xdrgen
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
  class TrustLineEntry < XDR::Struct
    include XDR::Namespace

    autoload :Ext

    attribute :account_id, AccountID
    attribute :currency,   Currency
    attribute :balance,    Int64
    attribute :limit,      Int64
    attribute :flags,      Uint32
    attribute :ext,        Ext
  end
end

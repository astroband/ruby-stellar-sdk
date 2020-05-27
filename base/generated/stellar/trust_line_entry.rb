# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct TrustLineEntry
#   {
#       AccountID accountID; // account this trustline belongs to
#       Asset asset;         // type of asset (with issuer)
#       int64 balance;       // how much of this asset the user has.
#                            // Asset defines the unit for this;
#   
#       int64 limit;  // balance cannot be above this
#       uint32 flags; // see TrustLineFlags
#   
#       // reserved for future use
#       union switch (int v)
#       {
#       case 0:
#           void;
#       case 1:
#           struct
#           {
#               Liabilities liabilities;
#   
#               union switch (int v)
#               {
#               case 0:
#                   void;
#               }
#               ext;
#           } v1;
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
    attribute :asset,      Asset
    attribute :balance,    Int64
    attribute :limit,      Int64
    attribute :flags,      Uint32
    attribute :ext,        Ext
  end
end

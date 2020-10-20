# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ClaimableBalanceEntry
#   {
#       // Unique identifier for this ClaimableBalanceEntry
#       ClaimableBalanceID balanceID;
#   
#       // List of claimants with associated predicate
#       Claimant claimants<10>;
#   
#       // Any asset including native
#       Asset asset;
#   
#       // Amount of asset
#       int64 amount;
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
  class ClaimableBalanceEntry < XDR::Struct
    include XDR::Namespace

    autoload :Ext

    attribute :balance_id, ClaimableBalanceID
    attribute :claimants,  XDR::VarArray[Claimant, 10]
    attribute :asset,      Asset
    attribute :amount,     Int64
    attribute :ext,        Ext
  end
end

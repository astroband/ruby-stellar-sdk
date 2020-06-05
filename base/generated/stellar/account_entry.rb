# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct AccountEntry
#   {
#       AccountID accountID;      // master public key for this account
#       int64 balance;            // in stroops
#       SequenceNumber seqNum;    // last sequence number used for this account
#       uint32 numSubEntries;     // number of sub-entries this account has
#                                 // drives the reserve
#       AccountID* inflationDest; // Account to vote for during inflation
#       uint32 flags;             // see AccountFlags
#   
#       string32 homeDomain; // can be used for reverse federation and memo lookup
#   
#       // fields used for signatures
#       // thresholds stores unsigned bytes: [weight of master|low|medium|high]
#       Thresholds thresholds;
#   
#       Signer signers<20>; // possible signers for this account
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
  class AccountEntry < XDR::Struct
    include XDR::Namespace

    autoload :Ext

    attribute :account_id,      AccountID
    attribute :balance,         Int64
    attribute :seq_num,         SequenceNumber
    attribute :num_sub_entries, Uint32
    attribute :inflation_dest,  XDR::Option[AccountID]
    attribute :flags,           Uint32
    attribute :home_domain,     String32
    attribute :thresholds,      Thresholds
    attribute :signers,         XDR::VarArray[Signer, 20]
    attribute :ext,             Ext
  end
end

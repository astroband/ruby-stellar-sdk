# Automatically generated on 2015-04-07T10:52:07-07:00
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
#       AccountID* inflationDest; // Account to vote during inflation
#       uint32 flags;             // see AccountFlags
#   
#       // fields used for signatures
#       // thresholds stores unsigned bytes: [weight of master|low|medium|high]
#       Thresholds thresholds;
#   
#       Signer signers<20>; // possible signers for this account
#   };
#
# ===========================================================================
module Stellar
  class AccountEntry < XDR::Struct
    attribute :account_id,      AccountID
    attribute :balance,         Int64
    attribute :seq_num,         SequenceNumber
    attribute :num_sub_entries, Uint32
    attribute :inflation_dest,  XDR::Option[AccountID]
    attribute :flags,           Uint32
    attribute :thresholds,      Thresholds
    attribute :signers,         XDR::VarArray[Signer, 20]
  end
end

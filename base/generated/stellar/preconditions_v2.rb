# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct PreconditionsV2
#   {
#       TimeBounds* timeBounds;
#   
#       // Transaction only valid for ledger numbers n such that
#       // minLedger <= n < maxLedger (if maxLedger == 0, then
#       // only minLedger is checked)
#       LedgerBounds* ledgerBounds;
#   
#       // If NULL, only valid when sourceAccount's sequence number
#       // is seqNum - 1.  Otherwise, valid when sourceAccount's
#       // sequence number n satisfies minSeqNum <= n < tx.seqNum.
#       // Note that after execution the account's sequence number
#       // is always raised to tx.seqNum, and a transaction is not
#       // valid if tx.seqNum is too high to ensure replay protection.
#       SequenceNumber* minSeqNum;
#   
#       // For the transaction to be valid, the current ledger time must
#       // be at least minSeqAge greater than sourceAccount's seqTime.
#       Duration minSeqAge;
#   
#       // For the transaction to be valid, the current ledger number
#       // must be at least minSeqLedgerGap greater than sourceAccount's
#       // seqLedger.
#       uint32 minSeqLedgerGap;
#   
#       // For the transaction to be valid, there must be a signature
#       // corresponding to every Signer in this array, even if the
#       // signature is not otherwise required by the sourceAccount or
#       // operations.
#       SignerKey extraSigners<2>;
#   };
#
# ===========================================================================
module Stellar
  class PreconditionsV2 < XDR::Struct
    attribute :time_bounds,        XDR::Option[TimeBounds]
    attribute :ledger_bounds,      XDR::Option[LedgerBounds]
    attribute :min_seq_num,        XDR::Option[SequenceNumber]
    attribute :min_seq_age,        Duration
    attribute :min_seq_ledger_gap, Uint32
    attribute :extra_signers,      XDR::VarArray[SignerKey, 2]
  end
end

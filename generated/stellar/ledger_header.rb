# Automatically generated on 2015-03-31T14:32:44-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct LedgerHeader
#   {
#       Hash previousLedgerHash; // hash of the previous ledger header
#       Hash txSetHash;          // the tx set that was SCP confirmed
#       Hash txSetResultHash;    // the TransactionResultSet that led to this ledger
#       Hash bucketListHash;     // hash of the ledger state
#   
#       uint32 ledgerSeq; // sequence number of this ledger
#       uint64 closeTime; // network close time
#   
#       int64 totalCoins; // total number of stroops in existence
#   
#       int64 feePool;       // fees burned since last inflation run
#       uint32 inflationSeq; // inflation sequence number
#   
#       uint64 idPool; // last used global ID, used for generating objects
#   
#       int32 baseFee;     // base fee per operation in stroops
#       int32 baseReserve; // account base reserve in stroops
#   };
#
# ===========================================================================
module Stellar
  class LedgerHeader < XDR::Struct
    attribute :previous_ledger_hash, Hash
    attribute :tx_set_hash,          Hash
    attribute :tx_set_result_hash,   Hash
    attribute :bucket_list_hash,     Hash
    attribute :ledger_seq,           Uint32
    attribute :close_time,           Uint64
    attribute :total_coins,          Int64
    attribute :fee_pool,             Int64
    attribute :inflation_seq,        Uint32
    attribute :id_pool,              Uint64
    attribute :base_fee,             Int32
    attribute :base_reserve,         Int32
  end
end

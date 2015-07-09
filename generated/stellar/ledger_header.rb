# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct LedgerHeader
#   {
#       uint32 ledgerVersion;    // the protocol version of the ledger
#       Hash previousLedgerHash; // hash of the previous ledger header
#       StellarValue scpValue;   // what consensus agreed to
#       Hash txSetResultHash;    // the TransactionResultSet that led to this ledger
#       Hash bucketListHash;     // hash of the ledger state
#   
#       uint32 ledgerSeq; // sequence number of this ledger
#   
#       int64 totalCoins; // total number of stroops in existence
#   
#       int64 feePool;       // fees burned since last inflation run
#       uint32 inflationSeq; // inflation sequence number
#   
#       uint64 idPool; // last used global ID, used for generating objects
#   
#       uint32 baseFee;     // base fee per operation in stroops
#       uint32 baseReserve; // account base reserve in stroops
#   
#       Hash skipList[4]; // hashes of ledgers in the past. allows you to jump back
#                         // in time without walking the chain back ledger by ledger
#                         // each slot contains the oldest ledger that is mod of
#                         // either 50  5000  50000 or 500000 depending on index
#                         // skipList[0] mod(50), skipList[1] mod(5000), etc
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
  class LedgerHeader < XDR::Struct
    include XDR::Namespace

    autoload :Ext

    attribute :ledger_version,       Uint32
    attribute :previous_ledger_hash, Hash
    attribute :scp_value,            StellarValue
    attribute :tx_set_result_hash,   Hash
    attribute :bucket_list_hash,     Hash
    attribute :ledger_seq,           Uint32
    attribute :total_coins,          Int64
    attribute :fee_pool,             Int64
    attribute :inflation_seq,        Uint32
    attribute :id_pool,              Uint64
    attribute :base_fee,             Uint32
    attribute :base_reserve,         Uint32
    attribute :skip_list,            XDR::Array[Hash, 4]
    attribute :ext,                  Ext
  end
end

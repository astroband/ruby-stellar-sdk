# Automatically generated from xdr/Stellar-ledger.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  class LedgerHeader < XDR::Struct

                                     
    attribute :hash,                 Hash
    attribute :previous_ledger_hash, Hash
    attribute :tx_set_hash,          Hash
    attribute :clf_hash,             Hash
    attribute :clf_levels,           XDR::Array[CLFLevel, 5]
    attribute :total_coins,          Int64
    attribute :fee_pool,             Int64
    attribute :ledger_seq,           Uint64
    attribute :inflation_seq,        Uint32
    attribute :base_fee,             Int32
    attribute :base_reserve,         Int32
    attribute :close_time,           Uint64
  end
end

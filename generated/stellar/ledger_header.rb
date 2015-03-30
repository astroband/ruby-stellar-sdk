# Automatically generated on 2015-03-30T09:46:31-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class LedgerHeader < XDR::Struct
    attribute :previous_ledger_hash, Hash
    attribute :tx_set_hash,          Hash
    attribute :tx_set_result_hash,   Hash
    attribute :clf_hash,             Hash
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

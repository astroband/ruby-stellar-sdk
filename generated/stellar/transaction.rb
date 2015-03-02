# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class Transaction < XDR::Struct
    autoload :Body, "#{File.dirname(__FILE__)}/transaction/body"
                           
    attribute :account,    AccountID
    attribute :max_fee,    Int32
    attribute :seq_slot,   Uint32
    attribute :seq_num,    Uint32
    attribute :min_ledger, Uint64
    attribute :max_ledger, Uint64
    attribute :body,       Body
  end
end

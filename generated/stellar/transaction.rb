# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  class Transaction < XDR::Struct
    autoload :Body, "#{__dir__}/transaction/body"
                           
    attribute :account,    AccountID
    attribute :max_fee,    Int32
    attribute :seq_num,    Uint32
    attribute :max_ledger, Uint64
    attribute :min_ledger, Uint64
    attribute :body,       Body
  end
end

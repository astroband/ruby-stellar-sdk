# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  class PaymentTx < XDR::Struct

                            
    attribute :destination, AccountID
    attribute :currency,    Currency
    attribute :amount,      Int64
    attribute :path,        XDR::VarArray[Currency]
    attribute :send_max,    Int64
    attribute :memo,        XDR::VarOpaque[32]
    attribute :source_memo, XDR::VarOpaque[32]
  end
end

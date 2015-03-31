# Automatically generated on 2015-03-31T14:32:44-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct PaymentOp
#   {
#       AccountID destination; // recipient of the payment
#       Currency currency;     // what they end up with
#       int64 amount;          // amount they end up with
#   
#       opaque memo<32>;
#       opaque sourceMemo<32>; // used to return a payment
#   
#       // payment over path
#       Currency path<5>; // what hops it must go through to get there
#       int64 sendMax; // the maximum amount of the source currency (==path[0]) to
#                      // send (excluding fees).
#                      // The operation will fail if can't be met
#   };
#
# ===========================================================================
module Stellar
  class PaymentOp < XDR::Struct
    attribute :destination, AccountID
    attribute :currency,    Currency
    attribute :amount,      Int64
    attribute :memo,        XDR::VarOpaque[32]
    attribute :source_memo, XDR::VarOpaque[32]
    attribute :path,        XDR::VarArray[Currency, 5]
    attribute :send_max,    Int64
  end
end

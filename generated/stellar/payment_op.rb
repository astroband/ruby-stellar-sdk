# Automatically generated on 2015-05-13T15:00:04-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct PaymentOp
#   {
#       AccountID destination; // recipient of the payment
#       Currency currency;     // what they end up with
#       int64 amount;          // amount they end up with
#   };
#
# ===========================================================================
module Stellar
  class PaymentOp < XDR::Struct
    attribute :destination, AccountID
    attribute :currency,    Currency
    attribute :amount,      Int64
  end
end

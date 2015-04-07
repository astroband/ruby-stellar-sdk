# Automatically generated on 2015-04-07T10:52:07-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct SimplePaymentResult
#   {
#       AccountID destination;
#       Currency currency;
#       int64 amount;
#   };
#
# ===========================================================================
module Stellar
  class SimplePaymentResult < XDR::Struct
    attribute :destination, AccountID
    attribute :currency,    Currency
    attribute :amount,      Int64
  end
end

# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  module Payment
    class PaymentResultCode < XDR::Enum
      member :success,        0
      member :success_multi,  1
      member :underfunded,    2
      member :no_destination, 3
      member :malformed,      4
      member :no_trust,       5
      member :not_authorized, 6
      member :line_full,      7
      member :oversendmax,    8

      seal
    end
  end
end

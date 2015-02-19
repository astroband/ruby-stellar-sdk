# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  module ChangeTrust
    class ChangeTrustResultCode < XDR::Enum
      member :success,    0
      member :no_account, 1

      seal
    end
  end
end

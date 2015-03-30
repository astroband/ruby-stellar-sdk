# Automatically generated on 2015-03-30T09:46:32-07:00
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

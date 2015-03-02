# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  module ChangeTrust
    class ChangeTrustResult < XDR::Union


      switch_on ChangeTrustResultCode, :code

      switch :success
      switch :default

    end
  end
end

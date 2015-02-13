# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  module ChangeTrust
    class ChangeTrustResult
      class Result < XDR::Union


        switch_on ChangeTrustResultCode, :code

        switch ChangeTrustResultCode.success
        switch :default

      end
    end
  end
end

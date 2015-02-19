# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  module CancelOffer
    class CancelOfferResult
      class Result < XDR::Union


        switch_on CancelOfferResultCode, :code

        switch CancelOfferResultCode.success
        switch :default

      end
    end
  end
end

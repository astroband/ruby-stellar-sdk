# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  module CreateOffer
    class CreateOfferResult
      class Result < XDR::Union


        switch_on CreateOfferResultCode, :code
                                              
        switch CreateOfferResultCode.success, :success
                                                      switch :default
                            
        attribute :success, CreateOfferSuccessResult
      end
    end
  end
end

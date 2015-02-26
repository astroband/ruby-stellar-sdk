# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  module CreateOffer
    class CreateOfferResult < XDR::Union


      switch_on CreateOfferResultCode, :code
                                            
      switch CreateOfferResultCode.success, :success
                                                  switch :default
                          
      attribute :success, CreateOfferSuccessResult
    end
  end
end

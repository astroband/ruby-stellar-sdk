# Automatically generated on 2015-03-30T09:46:32-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  module CreateOffer
    class CreateOfferResult < XDR::Union
      switch_on CreateOfferResultCode, :code

      switch :success, :success
      switch :default

      attribute :success, CreateOfferSuccessResult
    end
  end
end

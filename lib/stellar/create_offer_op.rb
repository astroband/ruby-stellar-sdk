module Stellar
  class CreateOfferOp
    include Stellar::Concerns::Operation

    def operation_switch
      :create_offer
    end 
  end
end
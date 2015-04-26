module Stellar
  CreateOfferOp.class_eval do

    def to_operation(source_account=nil)
      body = Operation::Body.new(:create_offer, self)
      Operation.new(source_account: source_account, body:body)
    end
    
  end
end
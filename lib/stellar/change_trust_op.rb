module Stellar
  ChangeTrustOp.class_eval do

    def to_operation(source_account=nil)
      body = Operation::Body.new(:change_trust, self)
      Operation.new(source_account: source_account, body:body)
    end
    
  end
end
module Stellar
  ChangeTrustTx.class_eval do

    def to_tx_body
      Transaction::Body.new(:change_trust, self)
    end
    
  end
end
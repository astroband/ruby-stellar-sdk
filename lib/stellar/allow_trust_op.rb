module Stellar
  class AllowTrustOp
    include Stellar::Concerns::Operation

    def operation_switch
      :allow_trust
    end 
  end
end
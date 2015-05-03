module Stellar
  class ChangeTrustOp
    include Stellar::Concerns::Operation

    def operation_switch
      :change_trust
    end
  end
end
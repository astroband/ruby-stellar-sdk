module Stellar
  class SetOptionsOp
    include Stellar::Concerns::Operation

    def operation_switch
      :set_options
    end 
  end
end
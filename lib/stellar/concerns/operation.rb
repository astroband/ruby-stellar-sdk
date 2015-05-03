module Stellar
  module Concerns
    module Operation

      def operation_switch
        raise NotImplementedError, "implement in including class"
      end

      def to_operation(source_account=nil)
        body = Stellar::Operation::Body.new(operation_switch, self)
        Stellar::Operation.new(source_account: source_account, body:body)
      end

    end
  end
end

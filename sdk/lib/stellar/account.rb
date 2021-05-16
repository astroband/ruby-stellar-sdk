module Stellar
  class Account
    def self.lookup(federated_name)
      Federation.lookup(federated_name)
    end
  end
end

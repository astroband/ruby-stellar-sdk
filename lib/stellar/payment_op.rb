module Stellar
  class PaymentOp

    def self.native(amount)
      currency = Stellar::Currency.native
      with_currency(currency).tap do |result|
        result.amount   = amount
      end
    end

    def self.iso4217(code, issuer, amount)
      currency = Stellar::Currency.iso4217(code, issuer)
      with_currency(currency).tap do |result|
        result.amount   = amount
      end
    end

    def self.with_currency(currency)
      new.tap do |result|
        result.currency = currency
      end
    end

    def apply_defaults
    end

  end
end
module Stellar
  PaymentOp.class_eval do

    def self.native(amount)
      currency = Stellar::Currency.new(:native)
      with_currency(currency).tap do |result|
        result.amount   = amount
        result.send_max = amount
      end
    end

    def self.iso4217(code, issuer, amount)
      currency = Stellar::Currency.iso4217(code, issuer)
      with_currency(currency).tap do |result|
        result.amount   = amount
        result.send_max = amount
      end
    end

    def self.with_currency(currency)
      new.tap do |result|
        result.currency = currency
        result.path     = []
      end
    end

    def apply_defaults
      self.source_memo ||= ""
      self.memo ||= ""
    end

    def to_operation(source_account=nil)
      body = Operation::Body.new(:payment, self)
      Operation.new(source_account: source_account, body:body)
    end

  end
end
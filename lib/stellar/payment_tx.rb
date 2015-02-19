module Stellar
  PaymentTx.class_eval do

    def self.native(amount)
      new.tap do |result|
        result.currency = Stellar::Currency.new(:native)
        result.path     = []
        result.amount   = amount
        result.send_max = amount
      end
    end

    def apply_defaults
      self.source_memo ||= ""
      self.memo ||= ""
    end

    def to_tx_body
      Transaction::Body.new(:payment, self)
    end
  end
end
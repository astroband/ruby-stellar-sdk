module Stellar
  class PathPaymentResult
    # send_amount returns the actual amount paid for the corresponding
    # PathPaymentOp to this result.
    #
    def send_amount
      s = success!
      return s.last.amount if s.offers.blank?

      source_currency = s.offers.first.currency_send
      source_offers = s.offers.take_while{|o| o.currency_send == source_currency}

      source_offers.map(&:amount_send).sum
    end

  end
end

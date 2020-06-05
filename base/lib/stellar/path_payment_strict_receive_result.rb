module Stellar
  class PathPaymentStrictReceiveResult
    # send_amount returns the actual amount paid for the corresponding
    # PathPaymentOp to this result.
    #
    def send_amount
      s = success!
      return s.last.amount if s.offers.blank?

      source_asset = s.offers.first.asset_bought
      source_offers = s.offers.take_while{|o| o.asset_bought == source_asset}

      source_offers.map(&:amount_bought).sum
    end

  end
end

module Stellar
  class PathPaymentResult
    # send_amount returns the actual amount paid for the corresponding
    # PathPaymentOp to this result.
    #
    def send_amount
      s = success!
      return s.last.amount if s.offers.blank?

      source_asset = s.offers.first.asset_send
      source_offers = s.offers.take_while{|o| o.asset_send == source_asset}

      source_offers.map(&:amount_send).sum
    end

  end
end

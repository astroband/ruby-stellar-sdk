module Stellar
  class Operation
    # 
    # Helper method to create a valid PaymentOp, wrapped
    # in the nexessary XDR structs to be included within a 
    # transactions `operations` array.
    # 
    # @see Stellar::Currency
    # 
    # @param [Hash] attributes the attributes to create the operation with
    # @option attributes [Stellar::KeyPair] :destination the receiver of the payment
    # @option attributes [Array] :amount the amount to pay
    # @option attributes [Array<Stellar::Currency>] :path the payment path to use
    # 
    # @return [Stellar::Operation] the built operation, containing a 
    #                              Stellar::PaymentOp body
    def self.payment(attributes={})
      destination = attributes[:destination]
      amount      = attributes[:amount]
      path        = attributes[:path] || []
      path        = path.map{|p| Stellar::Currency.send(*p)}

      raise ArgumentError unless destination.is_a?(KeyPair)

      op = PaymentOp.send(*amount)
      op.destination = destination.public_key
      op.path = path
      op.apply_defaults

      op.to_operation
    end

    # 
    # Helper method to create a valid ChangeTrustOp, wrapped
    # in the nexessary XDR structs to be included within a 
    # transactions `operations` array.
    # 
    # @param [Hash] attributes the attributes to create the operation with
    # @option attributes [Stellar::Currrency] :line the currency to trust
    # @option attributes [Fixnum] :limit the maximum amount to trust
    # 
    # @return [Stellar::Operation] the built operation, containing a 
    #                              Stellar::ChangeTrustOp body
    def self.change_trust(attributes={})
      line  = Currency.send(*attributes[:line])
      limit = attributes[:limit]

      raise ArgumentError, "Bad :limit #{limit}" unless limit.is_a?(Integer)

      op = ChangeTrustOp.new(line: line, limit: limit)
      op.to_operation
    end

    def self.create_offer(attributes={})
      taker_pays = Currency.send(*attributes[:taker_pays])
      taker_gets = Currency.send(*attributes[:taker_gets])
      amount     = attributes[:amount]
      offer_id   = attributes[:offer_id] || 0
      price      = Price.from_f(attributes[:price])

      op = CreateOfferOp.new({
        taker_pays: taker_pays, 
        taker_gets: taker_gets,
        amount:     amount,
        price:      price,
        offer_id:   offer_id
      })
      op.to_operation
    end

  end
end
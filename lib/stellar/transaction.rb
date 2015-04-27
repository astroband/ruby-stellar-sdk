module Stellar
  Transaction.class_eval do

    def self.payment(attributes={})
      destination = attributes[:destination]
      amount      = attributes[:amount]
      path        = attributes[:path] || []
      path        = path.map{|p| Stellar::Currency.iso4217(*p)}


      raise ArgumentError unless destination.is_a?(KeyPair)

      for_account(attributes).tap do |result|
        payment = PaymentOp.send(*amount)
        payment.destination = destination.public_key
        payment.path = path
        payment.apply_defaults

        result.operations = [payment.to_operation]
      end
    end

    def self.change_trust(attributes={})
      line  = Currency.send(*attributes[:line])
      limit = attributes[:limit]

      raise ArgumentError, "Bad :limit #{limit}" unless limit.is_a?(Integer)

      for_account(attributes).tap do |result|
        details = ChangeTrustOp.new(line: line, limit: limit)
        result.operations = [details.to_operation]
      end
    end

    def self.create_offer(attributes={})
      taker_pays = Currency.send(*attributes[:taker_pays])
      taker_gets = Currency.send(*attributes[:taker_gets])
      amount     = attributes[:amount]
      offer_id   = attributes[:offer_id] || 0
      price      = Price.from_f(attributes[:price])

      for_account(attributes).tap do |result|
        details = CreateOfferOp.new({
          taker_pays: taker_pays, 
          taker_gets: taker_gets,
          amount:     amount,
          price:      price,
          offer_id:   offer_id
        })
        result.operations = [details.to_operation]
      end
    end

    def self.for_account(attributes={})
      account       = attributes[:account]
      sequence      = attributes[:sequence]
      
      raise ArgumentError, "Bad :account" unless account.is_a?(KeyPair) && account.sign?
      raise ArgumentError, "Bad :sequence #{sequence}" unless sequence.is_a?(Integer)

      new.tap do |result|
        result.seq_num  = sequence
        result.source_account  = account.public_key
        result.apply_defaults
      end
    end

    def sign(key_pair)
      key_pair.sign(hash)
    end

    def sign_decorated(key_pair)
      key_pair.sign_decorated(hash)
    end

    def hash
      Digest::SHA256.digest(to_xdr)
    end

    def to_envelope(*key_pairs)
      signatures = key_pairs.map(&method(:sign_decorated))
      
      TransactionEnvelope.new({
        :signatures => signatures,
        :tx => self
      })
    end

    def apply_defaults
      self.max_fee    ||= 10
      self.min_ledger ||= 0
      self.max_ledger ||= 2**32 - 1
    end
  end
end
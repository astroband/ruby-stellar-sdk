module Stellar
  class Operation


    #
    # Construct a new Stellar::Operation from the provided
    # source account and body
    #
    # @param [Hash] attributes the attributes to create the operation with
    # @option attributes [Stellar::KeyPair] :source_account
    # @option attributes [Stellar::Operation::Body] :body
    #
    # @return [Stellar::Operation] the built operation
    def self.make(attributes={})
      source_account = attributes[:source_account]
      body           = Stellar::Operation::Body.new(*attributes[:body])

      op = Stellar::Operation.new(body:body)

      if source_account
        raise ArgumentError, "Bad :source_account" unless source_account.is_a?(Stellar::KeyPair)
        op.source_account = source_account.account_id
      end

      return op
    end


    #
    # Helper method to create a valid PaymentOp, wrapped
    # in the necessary XDR structs to be included within a
    # transactions `operations` array.
    #
    # @see Stellar::Currency
    #
    # @param [Hash] attributes the attributes to create the operation with
    # @option attributes [Stellar::KeyPair] :destination the receiver of the payment
    # @option attributes [Array] :amount the amount to pay
    # @return [Stellar::Operation] the built operation, containing a
    #                              Stellar::PaymentOp body
    def self.payment(attributes={})
      destination = attributes[:destination]
      currency, amount = extract_amount(attributes[:amount])

      raise ArgumentError unless destination.is_a?(KeyPair)


      op             = PaymentOp.new
      op.currency    = currency
      op.amount      = amount
      op.destination = destination.account_id

      return make(attributes.merge({
        body:[:payment, op]
      }))
    end

    #
    # Helper method to create a valid PathPaymentOp, wrapped
    # in the necessary XDR structs to be included within a
    # transactions `operations` array.
    #
    # @see Stellar::Currency
    #
    # @param [Hash] attributes the attributes to create the operation with
    # @option attributes [Stellar::KeyPair] :destination the receiver of the payment
    # @option attributes [Array] :amount the amount to pay
    # @option attributes [Array] :with the source currency and maximum allowed source amount to pay with
    # @option attributes [Array<Stellar::Currency>] :path the payment path to use
    #
    # @return [Stellar::Operation] the built operation, containing a
    #                              Stellar::PaymentOp body
    def self.path_payment(attributes={})
      destination             = attributes[:destination]
      currency, amount        = extract_amount(attributes[:amount])
      send_currency, send_max = extract_amount(attributes[:with])
      path                    = (attributes[:path] || []).map{|p| Stellar::Currency.send(*p)}

      raise ArgumentError unless destination.is_a?(KeyPair)

      op               = PathPaymentOp.new
      op.send_currency = send_currency
      op.send_max      = send_max
      op.destination   = destination.account_id
      op.dest_currency = currency
      op.dest_amount   = amount
      op.path          = path

      return make(attributes.merge({
        body:[:path_payment, op]
      }))
    end

    def self.create_account(attributes={})
      destination      = attributes[:destination]
      starting_balance = attributes[:starting_balance]

      raise ArgumentError unless destination.is_a?(KeyPair)

      op = CreateAccountOp.new()
      op.destination = destination.account_id
      op.starting_balance = starting_balance

      return make(attributes.merge({
        body:[:create_account, op]
      }))
    end

    #
    # Helper method to create a valid ChangeTrustOp, wrapped
    # in the necessary XDR structs to be included within a
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

      return make(attributes.merge({
        body:[:change_trust, op]
      }))
    end

    def self.manage_offer(attributes={})
      taker_pays = Currency.send(*attributes[:taker_pays])
      taker_gets = Currency.send(*attributes[:taker_gets])
      amount     = attributes[:amount]
      offer_id   = attributes[:offer_id] || 0
      price      = Price.from_f(attributes[:price])

      op = ManageOfferOp.new({
        taker_pays: taker_pays,
        taker_gets: taker_gets,
        amount:     amount,
        price:      price,
        offer_id:   offer_id
      })

      return make(attributes.merge({
        body:[:manage_offer, op]
      }))
    end

    def self.create_passive_offer(attributes={})
      taker_pays = Currency.send(*attributes[:taker_pays])
      taker_gets = Currency.send(*attributes[:taker_gets])
      amount     = attributes[:amount]
      price      = Price.from_f(attributes[:price])

      op = CreatePassiveOfferOp.new({
        taker_pays: taker_pays,
        taker_gets: taker_gets,
        amount:     amount,
        price:      price,
      })

      return make(attributes.merge({
        body:[:create_passive_offer, op]
      }))
    end

    #
    # Helper method to create a valid SetOptionsOp, wrapped
    # in the necessary XDR structs to be included within a
    # transactions `operations` array.
    #
    # @param [Hash] attributes the attributes to create the operation with
    # @option attributes [Stellar::KeyPair] :inflation_dest
    # @option attributes [Array<Stellar::AccountFlags>] :set flags to set
    # @option attributes [Array<Stellar::AccountFlags>] :clear flags to clear
    # @option attributes [String] :thresholds
    # @option attributes [Stellar::Signer] :signer
    #
    # @return [Stellar::Operation] the built operation, containing a
    #                              Stellar::SetOptionsOp body
    def self.set_options(attributes={})
      op             = SetOptionsOp.new()
      op.set_flags   = Stellar::AccountFlags.make_mask attributes[:set]
      op.clear_flags = Stellar::AccountFlags.make_mask attributes[:clear]
      op.thresholds  = attributes[:thresholds]
      op.signer      = attributes[:signer]
      op.home_domain = attributes[:home_domain]


      inflation_dest = attributes[:inflation_dest]
      if inflation_dest
        raise ArgumentError, "Bad :inflation_dest" unless inflation_dest.is_a?(Stellar::KeyPair)
        op.inflation_dest = inflation_dest.account_id
      end


      return make(attributes.merge({
        body:[:set_options, op]
      }))
    end

    #
    # Helper method to create a valid AllowTrustOp, wrapped
    # in the necessary XDR structs to be included within a
    # transactions `operations` array.
    #
    # @param [Hash] attributes the attributes to create the operation with
    # @option attributes [Stellar::KeyPair]  :trustor
    # @option attributes [Stellar::Currency] :currency
    #
    # @return [Stellar::Operation] the built operation, containing a
    #                              Stellar::AllowTrustOp body
    def self.allow_trust(attributes={})
      op = AllowTrustOp.new()

      trustor   = attributes[:trustor]
      authorize = attributes[:authorize]
      currency  = Currency.send(*attributes[:currency])

      raise ArgumentError, "Bad :trustor" unless trustor.is_a?(Stellar::KeyPair)
      raise ArgumentError, "Bad :authorize" unless authorize == !!authorize # check boolean
      raise ArgumentError, "Bad :currency" unless currency.type == Stellar::CurrencyType.currency_type_alphanum

      atc = AllowTrustOp::Currency.new(:currency_type_alphanum, currency.code)

      op.trustor   = trustor.account_id
      op.authorize = authorize
      op.currency  = atc

      return make(attributes.merge({
        body:[:allow_trust, op]
      }))
    end

    #
    # Helper method to create an account merge operation
    #
    # @param [Hash] attributes the attributes to create the operation with
    # @option attributes [Stellar::KeyPair]  :destination
    #
    # @return [Stellar::Operation] the built operation
    def self.account_merge(attributes={})
      destination = attributes[:destination]

      raise ArgumentError, "Bad :destination" unless destination.is_a?(KeyPair)

      # TODO: add source_account support
      return make(attributes.merge({
        body:[:account_merge, destination.account_id]
      }))
    end

    #
    # Helper method to create an inflation operation
    #
    # @param [Hash] attributes the attributes to create the operation with
    # @option attributes [Integer]  :sequence
    #
    # @return [Stellar::Operation] the built operation
    def self.inflation(attributes={})
      sequence = attributes[:sequence]

      raise ArgumentError, "Bad :sequence #{sequence}" unless sequence.is_a?(Integer)

      # TODO: add source_account support
      return make(attributes.merge({
        body:[:inflation]
      }))
    end

    private
    def self.extract_amount(a)
      amount   = a.last
      currency = Stellar::Currency.send(*a[0...-1])

      return currency, amount
    end
  end
end

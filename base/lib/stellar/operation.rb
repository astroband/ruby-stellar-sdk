require "bigdecimal"

module Stellar
  class Operation < StellarProtocol::Operation
    MAX_INT64 = 2**63 - 1
    TRUST_LINE_FLAGS_MAPPING = {
      full: StellarProtocol::TrustLineFlags.authorized_flag,
      maintain_liabilities: StellarProtocol::TrustLineFlags.authorized_to_maintain_liabilities_flag,
      clawback_enabled: StellarProtocol::TrustLineFlags.trustline_clawback_enabled_flag
    }.freeze

    class << self
      include Stellar::DSL
      #
      # Construct a new Stellar::Operation from the provided
      # source account and body
      #
      # @param [Hash] attributes the attributes to create the operation with
      # @option attributes [Stellar::KeyPair] :source_account
      # @option attributes [Stellar::Operation::Body] :body
      #
      # @return [Stellar::Operation] the built operation
      def make(attributes = {})
        source_account = attributes[:source_account]

        if source_account && !source_account.is_a?(Stellar::KeyPair)
          raise ArgumentError, "Bad :source_account"
        end

        body = StellarProtocol::Operation::Body.new(*attributes[:body])

        Operation.new(
          body: body,
          source_account: source_account&.muxed_account
        )
      end

      #
      # Helper method to create a valid PaymentOp, wrapped
      # in the necessary XDR structs to be included within a
      # transactions `operations` array.
      #
      # @see Stellar::Asset
      #
      # @param [Hash] attributes the attributes to create the operation with
      # @option attributes [Stellar::KeyPair] :destination the receiver of the payment
      # @option attributes [Array] :amount the amount to pay
      # @return [Stellar::Operation] the built operation, containing a
      #                              Stellar::PaymentOp body
      def payment(attributes = {})
        destination = attributes[:destination]
        asset, amount = get_asset_amount(attributes[:amount])

        raise ArgumentError unless destination.is_a?(KeyPair)

        op = StellarProtocol::PaymentOp.new
        op.asset = asset
        op.amount = amount
        op.destination = destination.muxed_account

        make(attributes.merge({
          body: [:payment, op]
        }))
      end

      #
      # Helper method to create a valid PathPaymentStrictReceiveOp, wrapped
      # in the necessary XDR structs to be included within a
      # transactions `operations` array.
      #
      # @deprecated Please use Operation.path_payment_strict_receive
      #
      # @see Stellar::Asset
      #
      # @param [Hash] attributes the attributes to create the operation with
      # @option attributes [Stellar::KeyPair] :destination the receiver of the payment
      # @option attributes [Array] :amount the destination asset and the amount to pay
      # @option attributes [Array] :with the source asset and maximum allowed source amount to pay with
      # @option attributes [Array<Stellar::Asset>] :path the payment path to use
      #
      # @return [Stellar::Operation] the built operation, containing a Stellar::PaymentOp body
      #
      def path_payment(attributes = {})
        path_payment_strict_receive(attributes)
      end

      #
      # Helper method to create a valid PathPaymentStrictReceiveOp, wrapped
      # in the necessary XDR structs to be included within a
      # transactions `operations` array.
      #
      # @see Stellar::Asset
      #
      # @param [Hash] attributes the attributes to create the operation with
      # @option attributes [Stellar::KeyPair] :destination the receiver of the payment
      # @option attributes [Array] :amount the destination asset and the amount to pay
      # @option attributes [Array] :with the source asset and maximum allowed source amount to pay with
      # @option attributes [Array<Stellar::Asset>] :path the payment path to use
      #
      # @return [Stellar::Operation] the built operation, containing a Stellar::PaymentOp body
      #
      def path_payment_strict_receive(attributes = {})
        destination = attributes[:destination]
        asset, amount = get_asset_amount(attributes[:amount])
        send_asset, send_max = get_asset_amount(attributes[:with])
        path = (attributes[:path] || []).map { |p|
          p.is_a?(Array) ? Asset.send(*p) : p
        }

        raise ArgumentError unless destination.is_a?(KeyPair)

        op = StellarProtocol::PathPaymentStrictReceiveOp.new
        op.send_asset = send_asset
        op.send_max = send_max
        op.destination = destination.muxed_account
        op.dest_asset = asset
        op.dest_amount = amount
        op.path = path

        make(attributes.merge({
          body: [:path_payment_strict_receive, op]
        }))
      end

      #
      # Helper method to create a valid PathPaymentStrictSendOp, wrapped
      # in the necessary XDR structs to be included within a
      # transactions `operations` array.
      #
      # @see Stellar::Asset
      #
      # @param [Hash] attributes the attributes to create the operation with
      # @option attributes [Stellar::KeyPair] :destination the receiver of the payment
      # @option attributes [Array] :amount the destination asset and the minimum amount of destination asset to be received
      # @option attributes [Array] :with the source asset and amount to pay with
      # @option attributes [Array<Stellar::Asset>] :path the payment path to use
      #
      # @return [Stellar::Operation] the built operation, containing a Stellar::PaymentOp body
      #
      def path_payment_strict_send(attributes = {})
        destination = attributes[:destination]
        asset, dest_min = get_asset_amount(attributes[:amount])
        send_asset, send_amount = get_asset_amount(attributes[:with])
        path = (attributes[:path] || []).map { |p|
          p.is_a?(Array) ? Asset.send(*p) : p
        }

        raise ArgumentError unless destination.is_a?(KeyPair)

        op = StellarProtocol::PathPaymentStrictSendOp.new
        op.send_asset = send_asset
        op.send_amount = send_amount
        op.destination = destination.muxed_account
        op.dest_asset = asset
        op.dest_min = dest_min
        op.path = path

        make(attributes.merge({
          body: [:path_payment_strict_send, op]
        }))
      end

      def create_account(attributes = {})
        destination = attributes[:destination]
        starting_balance = interpret_amount(attributes[:starting_balance])

        raise ArgumentError unless destination.is_a?(KeyPair)

        op = StellarProtocol::CreateAccountOp.new
        op.destination = destination.account_id
        op.starting_balance = starting_balance

        make(attributes.merge({
          body: [:create_account, op]
        }))
      end

      # Helper method to create a valid ChangeTrustOp, wrapped
      # in the necessary XDR structs to be included within a
      # transactions `operations` array.
      #
      # @param [Hash] attributes the attributes to create the operation with
      # @option attributes [Stellar::Asset] :line the asset to trust
      # @option attributes [Fixnum] :limit the maximum amount to trust, defaults to max int64,
      #                                    if the limit is set to 0 it deletes the trustline.
      #
      # @return [Stellar::Operation] the built operation, containing a
      #                              Stellar::ChangeTrustOp body
      def change_trust(attributes = {})
        line = attributes[:line]
        unless line.is_a?(Asset)
          unless Asset::TYPES.include?(line[0])
            fail ArgumentError, "must be one of #{Asset::TYPES}"
          end
          line = Asset.send(*line)
        end

        limit = attributes.key?(:limit) ? interpret_amount(attributes[:limit]) : MAX_INT64

        raise ArgumentError, "Bad :limit #{limit}" unless limit.is_a?(Integer)

        op = StellarProtocol::ChangeTrustOp.new(line: line, limit: limit)

        make(attributes.merge({
          body: [:change_trust, op]
        }))
      end

      # Helper method to create a valid CreateClaimableBalanceOp, ready to be used
      # within a transactions `operations` array.
      #
      # @see Stellar::DSL::Claimant
      # @see https://github.com/astroband/ruby-stellar-sdk/tree/master/base/examples/claimable_balances.rb
      #
      # @param asset [Asset] the asset to transfer to a claimable balance
      # @param amount [Fixnum] the amount of `asset` to put into a claimable balance
      # @param claimants [Array<Claimant>] accounts authorized to claim the balance in the future
      #
      # @return [Operation] the built operation
      def create_claimable_balance(asset:, amount:, claimants:, **attributes)
        op = StellarProtocol::CreateClaimableBalanceOp.new(asset: asset, amount: amount, claimants: claimants)

        make(attributes.merge(body: [:create_claimable_balance, op]))
      end

      # Helper method to create a valid CreateClaimableBalanceOp, ready to be used
      # within a transactions `operations` array.
      #
      # @see Stellar::DSL::Claimant
      # @see https://github.com/astroband/ruby-stellar-sdk/tree/master/base/examples/claimable_balances.rb
      #
      # @param balance_id [ClaimableBalanceID] unique ID of claimable balance
      #
      # @return [Operation] the built operation, containing a Stellar::ChangeTrustOp body
      def claim_claimable_balance(balance_id:, **attributes)
        op = StellarProtocol::ClaimClaimableBalanceOp.new(balance_id: balance_id)

        make(attributes.merge(body: [:claim_claimable_balance, op]))
      end

      def begin_sponsoring_future_reserves(sponsored:, **attributes)
        op = StellarProtocol::BeginSponsoringFutureReservesOp.new(
          sponsored_id: KeyPair(sponsored).account_id
        )

        make(attributes.merge(body: [:begin_sponsoring_future_reserves, op]))
      end

      def end_sponsoring_future_reserves(**attributes)
        make(attributes.merge(body: [:end_sponsoring_future_reserves]))
      end

      # @param sponsored [#to_keypair] owner of sponsored entry
      def revoke_sponsorship(sponsored:, **attributes)
        key_fields = attributes.slice(:offer_id, :data_name, :balance_id, :asset, :signer)
        raise ArgumentError, "conflicting attributes: #{key_fields.keys.join(", ")}" if key_fields.size > 1
        account_id = KeyPair(sponsored).account_id
        key, value = key_fields.first
        op = if key == :signer
          StellarProtocol::RevokeSponsorshipOp.signer(account_id: account_id, signer_key: SignerKey(value))
        else
          StellarProtocol::RevokeSponsorshipOp.ledger_key(
            StellarProtocol::LedgerKey.from(account_id: account_id, **key_fields)
          )
        end
        make(attributes.merge(body: [:revoke_sponsorship, op]))
      end

      def manage_sell_offer(attributes = {})
        buying = attributes[:buying]
        if buying.is_a?(Array)
          buying = Asset.send(*buying)
        end
        selling = attributes[:selling]
        if selling.is_a?(Array)
          selling = Asset.send(*selling)
        end
        amount = interpret_amount(attributes[:amount])
        offer_id = attributes[:offer_id] || 0
        price = interpret_price(attributes[:price])

        op = StellarProtocol::ManageSellOfferOp.new({
          buying: buying,
          selling: selling,
          amount: amount,
          price: price,
          offer_id: offer_id
        })

        make(attributes.merge({
          body: [:manage_sell_offer, op]
        }))
      end

      def manage_buy_offer(attributes = {})
        buying = attributes[:buying]
        if buying.is_a?(Array)
          buying = Asset.send(*buying)
        end
        selling = attributes[:selling]
        if selling.is_a?(Array)
          selling = Asset.send(*selling)
        end
        amount = interpret_amount(attributes[:amount])
        offer_id = attributes[:offer_id] || 0
        price = interpret_price(attributes[:price])

        op = StellarProtocol::ManageBuyOfferOp.new({
          buying: buying,
          selling: selling,
          buy_amount: amount,
          price: price,
          offer_id: offer_id
        })

        make(attributes.merge({
          body: [:manage_buy_offer, op]
        }))
      end

      def create_passive_sell_offer(attributes = {})
        buying = attributes[:buying]
        if buying.is_a?(Array)
          buying = Asset.send(*buying)
        end
        selling = attributes[:selling]
        if selling.is_a?(Array)
          selling = Asset.send(*selling)
        end
        amount = interpret_amount(attributes[:amount])
        price = interpret_price(attributes[:price])

        op = StellarProtocol::CreatePassiveSellOfferOp.new({
          buying: buying,
          selling: selling,
          amount: amount,
          price: price
        })

        make(attributes.merge({
          body: [:create_passive_sell_offer, op]
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
      def set_options(attributes = {})
        op = StellarProtocol::SetOptionsOp.new
        op.set_flags = StellarProtocol::AccountFlags.make_mask attributes[:set]
        op.clear_flags = StellarProtocol::AccountFlags.make_mask attributes[:clear]
        op.master_weight = attributes[:master_weight]
        op.low_threshold = attributes[:low_threshold]
        op.med_threshold = attributes[:med_threshold]
        op.high_threshold = attributes[:high_threshold]

        op.signer = attributes[:signer]
        op.home_domain = attributes[:home_domain]

        inflation_dest = attributes[:inflation_dest]
        if inflation_dest
          raise ArgumentError, "Bad :inflation_dest" unless inflation_dest.is_a?(KeyPair)
          op.inflation_dest = inflation_dest.account_id
        end

        make(attributes.merge({
          body: [:set_options, op]
        }))
      end

      # @param asset [Stellar::Asset]
      # @param trustor [Stellar::KeyPair]
      # @param flags [{String, Symbol, Stellar::TrustLineFlags => true, false}] flags to to set or clear
      # @param source_account [Stellar::KeyPair]  source account (default is `nil`, which will use the source account of transaction)
      def set_trust_line_flags(asset:, trustor:, flags: {}, source_account: nil)
        op = StellarProtocol::SetTrustLineFlagsOp.new
        op.trustor = KeyPair(trustor).account_id
        op.asset = Asset(asset)
        op.attributes = StellarProtocol::TrustLineFlags.set_clear_masks(flags)

        make(
          source_account: source_account,
          body: [:set_trust_line_flags, op]
        )
      end

      # DEPRECATED in favor of `set_trustline_flags`
      #
      # Helper method to create a valid AllowTrustOp, wrapped
      # in the necessary XDR structs to be included within a
      # transactions `operations` array.
      #
      # @deprecated Use `set_trustline_flags` operation
      #   See {https://github.com/stellar/stellar-protocol/blob/master/core/cap-0035.md#allow-trust-operation-1 CAP-35 description}
      #   for more details
      # @param [Hash] attributes the attributes to create the operation with
      # @option attributes [Stellar::KeyPair] :trustor
      # @option attributes [Stellar::Asset] :asset
      # @option attributes [Symbol, Boolean] :authorize :full, maintain_liabilities or :none
      #
      # @return [Stellar::Operation] the built operation, containing a
      #                              Stellar::AllowTrustOp body
      def allow_trust(attributes = {})
        op = StellarProtocol::AllowTrustOp.new

        trustor = attributes[:trustor]
        # we handle booleans here for the backward compatibility
        authorize = attributes[:authorize].yield_self { |value| value == true ? :full : value }
        asset = attributes[:asset]
        if asset.is_a?(Array)
          asset = Asset.send(*asset)
        end

        raise ArgumentError, "Bad :trustor" unless trustor.is_a?(KeyPair)

        allowed_flags = TRUST_LINE_FLAGS_MAPPING.slice(:full, :maintain_liabilities)

        # we handle booleans here for the backward compatibility
        op.authorize = if allowed_flags.key?(authorize)
          allowed_flags[authorize].value
        elsif [:none, false].include?(authorize)
          0
        else
          raise ArgumentError, "Bad :authorize, supported values: :full, :maintain_liabilities, :none"
        end

        raise ArgumentError, "Bad :asset" unless asset.type == StellarProtocol::AssetType.asset_type_credit_alphanum4

        op.trustor = trustor.account_id
        op.asset = StellarProtocol::AssetCode.new(:asset_type_credit_alphanum4, asset.code)

        make(attributes.merge({
          body: [:allow_trust, op]
        }))
      end

      #
      # Helper method to create an account merge operation
      #
      # @param [Hash] attributes the attributes to create the operation with
      # @option attributes [Stellar::KeyPair]  :destination
      #
      # @return [Stellar::Operation] the built operation
      def account_merge(attributes = {})
        destination = attributes[:destination]

        raise ArgumentError, "Bad :destination" unless destination.is_a?(KeyPair)

        # TODO: add source_account support
        make(attributes.merge({
          body: [:account_merge, destination.muxed_account]
        }))
      end

      #
      # Helper method to create an inflation operation
      #
      # @param [Hash] attributes the attributes to create the operation with
      # @option attributes [Integer]  :sequence
      #
      # @return [Stellar::Operation] the built operation
      def inflation(attributes = {})
        sequence = attributes[:sequence]

        raise ArgumentError, "Bad :sequence #{sequence}" unless sequence.is_a?(Integer)

        # TODO: add source_account support
        make(attributes.merge({
          body: [:inflation]
        }))
      end

      #
      # Helper method to create an manage data operation
      #
      # @param [Hash] attributes the attributes to create the operation with
      # @option attributes [Integer]  :sequence
      #
      # @return [Stellar::Operation] the built operation
      def manage_data(attributes = {})
        op = StellarProtocol::ManageDataOp.new

        name = attributes[:name]
        value = attributes[:value]

        raise ArgumentError, "Invalid :name" unless name.is_a?(String)
        raise ArgumentError, ":name too long" unless name.bytesize <= 64

        if value.present?
          raise ArgumentError, ":value too long" unless value.bytesize <= 64
        end

        op.data_name = name
        op.data_value = value

        make(attributes.merge({
          body: [:manage_data, op]
        }))
      end

      def bump_sequence(attributes = {})
        op = StellarProtocol::BumpSequenceOp.new

        bump_to = attributes[:bump_to]

        raise ArgumentError, ":bump_to too big" unless bump_to <= MAX_INT64

        op.bump_to = bump_to

        make(attributes.merge({
          body: [:bump_sequence, op]
        }))
      end

      def clawback(source_account:, from:, amount:)
        asset, amount = get_asset_amount(amount)

        if amount == 0
          raise ArgumentError, "Amount can not be zero"
        end

        if amount < 0
          raise ArgumentError, "Negative amount is not allowed"
        end

        op = StellarProtocol::ClawbackOp.new(
          amount: amount,
          from: from.muxed_account,
          asset: asset
        )

        make({
          source_account: source_account,
          body: [:clawback, op]
        })
      end

      # Helper method to create clawback claimable balance operation
      #
      # @param [Stellar::KeyPair] source_account the attributes to create the operation with
      # @param [String] balance_id `ClaimableBalanceID`, serialized in hex
      #
      # @return [Stellar::Operation] the built operation
      def clawback_claimable_balance(source_account:, balance_id:)
        balance_id = StellarProtocol::ClaimableBalanceID.from_xdr(balance_id, :hex)
        op = StellarProtocol::ClawbackClaimableBalanceOp.new(balance_id: balance_id)

        make(
          source_account: source_account,
          body: [:clawback_claimable_balance, op]
        )
      rescue XDR::ReadError
        raise ArgumentError, "Claimable balance id '#{balance_id}' is invalid"
      end

      private

      def get_asset_amount(values)
        amount = interpret_amount(values.last)
        asset = (values[0].is_a?(Asset) ? values.first : Asset.send(*values[0...-1]))

        [asset, amount]
      end

      def interpret_amount(amount)
        case amount
        when String
          (BigDecimal(amount) * Stellar::ONE).floor
        when Integer
          amount * Stellar::ONE
        when Numeric
          (amount * Stellar::ONE).floor
        else
          raise ArgumentError, "Invalid amount type: #{amount.class}. Must be String or Numeric"
        end
      end

      def interpret_price(price)
        case price
        when String
          bd = BigDecimal(price)
          Price.from_f(bd)
        when Numeric
          Price.from_f(price)
        when Price
          price
        else
          raise ArgumentError, "Invalid price type: #{price.class}. Must be String, Numeric, or Stellar::Price"
        end
      end
    end
  end
end

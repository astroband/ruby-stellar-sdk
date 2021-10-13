require "bigdecimal"

module Stellar
  class Operation
    MAX_INT64 = 2**63 - 1
    TRUST_LINE_FLAGS_MAPPING = {
      full: Stellar::TrustLineFlags.authorized_flag,
      maintain_liabilities: Stellar::TrustLineFlags.authorized_to_maintain_liabilities_flag,
      clawback_enabled: Stellar::TrustLineFlags.trustline_clawback_enabled_flag
    }.freeze

    class << self
      include Stellar::DSL
      #
      # Construct a new Stellar::Operation from the provided
      # source account and body
      #
      # @param source_account [KeyPair, nil] the source account for the operation
      # @param [(Symbol, XDR::Struct)] body a tuple containing operation type and operation object
      #
      # @return [Stellar::Operation] the built operation
      def make(body:, source_account: nil)
        raise ArgumentError, "Bad :source_account" if source_account && !source_account.is_a?(Stellar::KeyPair)

        body = Stellar::Operation::Body.new(*body)

        Stellar::Operation.new(
          source_account: source_account&.muxed_account,
          body: body
        )
      end

      # Create Account operation builder
      #
      # @param source_account [KeyPair, nil] the source account for the operation
      # @param destination [KeyPair] the account to create
      # @param starting_balance [String, Numeric] the amount to deposit to the newly created account
      #
      # @return [Stellar::Operation] the built operation
      def create_account(destination:, starting_balance:, source_account: nil)
        op = CreateAccountOp.new(
          destination: KeyPair(destination).account_id,
          starting_balance: interpret_amount(starting_balance)
        )

        make(source_account: source_account, body: [:create_account, op])
      end

      # Account Merge operation builder
      #
      # @param [Stellar::KeyPair, nil] source_account the source account for the operation
      # @param [Stellar::KeyPair] destination the account to merge into
      #
      # @return [Stellar::Operation] the built operation
      def account_merge(destination:, source_account: nil)
        raise ArgumentError, "Bad destination" unless destination.is_a?(KeyPair)

        make(source_account: source_account, body: [:account_merge, destination.muxed_account])
      end

      # Set Options operation builder.
      #
      # @param source_account [KeyPair, nil] the source account for the operation
      # @param home_domain [String, nil] the home domain of the account
      # @param signer [Signer, nil] add, remove or adjust weight of the co-signer
      # @param set [Array<AccountFlags>] flags to set
      # @param clear [Array<AccountFlags>] flags to clear
      # @param inflation_dest [KeyPair, nil] the inflation destination of the account
      #
      # @return [Stellar::Operation] the built operation
      def set_options(set: [], clear: [], home_domain: nil, signer: nil, inflation_dest: nil, source_account: nil, **attributes)
        raise ArgumentError, "Bad inflation_dest" if inflation_dest && !inflation_dest.is_a?(KeyPair)

        op = SetOptionsOp.new(
          set_flags: Stellar::AccountFlags.make_mask(set),
          clear_flags: Stellar::AccountFlags.make_mask(clear),
          master_weight: attributes[:master_weight],
          low_threshold: attributes[:low_threshold],
          med_threshold: attributes[:med_threshold],
          high_threshold: attributes[:high_threshold],
          signer: signer,
          home_domain: home_domain,
          inflation_dest: inflation_dest&.account_id
        )

        make(source_account: source_account, body: [:set_options, op])
      end

      # Bump Sequence operation builder
      #
      # @param [Stellar::KeyPair] source_account the source account for the operation
      # @param [Integer] bump_to the target sequence number for the account
      #
      # @return [Stellar::Operation] the built operation
      def bump_sequence(bump_to:, source_account: nil)
        raise ArgumentError, ":bump_to too big" unless bump_to <= MAX_INT64

        op = BumpSequenceOp.new(
          bump_to: bump_to
        )

        make(source_account: source_account, body: [:bump_sequence, op])
      end

      # Manage Data operation builder
      #
      # @param [Stellar::KeyPair, nil] source_account the source account for the operation
      # @param [String] name the name of the data entry
      # @param [String, nil] value the value of the data entry (nil to remove the entry)
      #
      # @return [Stellar::Operation] the built operation
      def manage_data(name:, value: nil, source_account: nil)
        raise ArgumentError, "Invalid :name" unless name.is_a?(String)
        raise ArgumentError, ":name too long" if name.bytesize > 64
        raise ArgumentError, ":value too long" if value && value.bytesize > 64

        op = ManageDataOp.new(
          data_name: name,
          data_value: value
        )

        make(source_account: source_account, body: [:manage_data, op])
      end

      # Change Trust operation builder
      #
      # @param source_account [KeyPair, nil] the source account for the operation
      # @param asset [Asset] the asset to trust
      # @param limit [String, Numeric] the maximum amount to trust, defaults to max int64 (0 deletes the trustline)
      #
      # @return [Stellar::Operation] the built operation
      def change_trust(asset: nil, limit: nil, source_account: nil, **attrs)
        if attrs.key?(:line) && !asset
          Stellar::Deprecation.warn("`line` parameter is deprecated, use `asset` instead")
          asset = attrs[:line]
        end

        op = ChangeTrustOp.new(
          line: Asset(asset).to_change_trust_asset,
          limit: limit ? interpret_amount(limit) : MAX_INT64
        )

        make(source_account: source_account, body: [:change_trust, op])
      end

      # Set Trustline Flags operation builder
      #
      # @param source_account [KeyPair, nil] the source account for the operation
      # @param asset [Stellar::Asset]
      # @param trustor [Stellar::KeyPair]
      # @param flags [{String, Symbol, Stellar::TrustLineFlags => true, false}] flags to to set or clear
      #
      # @return [Stellar::Operation] the built operation
      def set_trust_line_flags(asset:, trustor:, flags: {}, source_account: nil)
        op = Stellar::SetTrustLineFlagsOp.new(
          trustor: KeyPair(trustor).account_id,
          asset: Asset(asset),
          attributes: TrustLineFlags.set_clear_masks(flags)
        )

        make(source_account: source_account, body: [:set_trust_line_flags, op])
      end

      # Clawback operation builder
      #
      # @param [Stellar::KeyPair] source_account the source account for the operation
      # @param [String|Account|PublicKey|SignerKey|KeyPair] from the account to clawback from
      # @param [(Asset, Numeric)] amount the amount of asset to subtract from the balance
      #
      # @return [Stellar::Operation] the built operation
      def clawback(from:, amount:, source_account: nil)
        asset, amount = get_asset_amount(amount)

        if amount == 0
          raise ArgumentError, "Amount can not be zero"
        end

        if amount < 0
          raise ArgumentError, "Negative amount is not allowed"
        end

        op = ClawbackOp.new(
          amount: amount,
          from: KeyPair(from).muxed_account,
          asset: asset
        )

        make(source_account: source_account, body: [:clawback, op])
      end

      # Create Claimable Balance operation builder.
      #
      # @see Stellar::DSL::Claimant
      # @see https://github.com/astroband/ruby-stellar-sdk/tree/master/base/examples/claimable_balances.rb
      #
      # @param source_account [KeyPair, nil] the source account for the operation
      # @param asset [Asset] the asset to transfer to a claimable balance
      # @param amount [Fixnum] the amount of `asset` to put into a claimable balance
      # @param claimants [Array<Claimant>] accounts authorized to claim the balance in the future
      #
      # @return [Operation] the built operation
      def create_claimable_balance(asset:, amount:, claimants:, source_account: nil)
        op = CreateClaimableBalanceOp.new(asset: asset, amount: amount, claimants: claimants)

        make(source_account: source_account, body: [:create_claimable_balance, op])
      end

      # Helper method to create a valid CreateClaimableBalanceOp, ready to be used
      # within a transactions `operations` array.
      #
      # @see Stellar::DSL::Claimant
      # @see https://github.com/astroband/ruby-stellar-sdk/tree/master/base/examples/claimable_balances.rb
      #
      # @param source_account [KeyPair, nil] the source account for the operation
      # @param balance_id [ClaimableBalanceID] unique ID of claimable balance
      #
      # @return [Operation] the built operation
      def claim_claimable_balance(balance_id:, source_account: nil)
        op = ClaimClaimableBalanceOp.new(balance_id: balance_id)

        make(source_account: source_account, body: [:claim_claimable_balance, op])
      end

      # Clawback Claimable Balance operation builder
      #
      # @param [Stellar::KeyPair] source_account the source account for the operation
      # @param [String] balance_id claimable balance ID as a hexadecimal string
      #
      # @return [Stellar::Operation] the built operation
      def clawback_claimable_balance(balance_id:, source_account: nil)
        balance_id = Stellar::ClaimableBalanceID.from_xdr(balance_id, :hex)
        op = ClawbackClaimableBalanceOp.new(balance_id: balance_id)

        make(source_account: source_account, body: [:clawback_claimable_balance, op])
      rescue XDR::ReadError
        raise ArgumentError, "Claimable balance id '#{balance_id}' is invalid"
      end

      # Payment Operation builder
      #
      # @param source_account [KeyPair, nil] the source account for the operation
      # @param [Stellar::KeyPair] destination the receiver of the payment
      # @param [(Asset, Numeric)] amount the amount to pay
      #
      # @return [Stellar::Operation] the built operation
      def payment(destination:, amount:, source_account: nil)
        raise ArgumentError unless destination.is_a?(KeyPair)
        asset, amount = get_asset_amount(amount)

        op = PaymentOp.new(
          asset: asset,
          amount: amount,
          destination: destination.muxed_account
        )

        make(
          source_account: source_account,
          body: [:payment, op]
        )
      end

      # Path Payment Strict Receive operation builder.
      #
      # @param source_account [KeyPair, nil] the source account for the operation
      # @param destination [Stellar::KeyPair] the receiver of the payment
      # @param amount [Array] the destination asset and the amount to pay
      # @param with [Array] the source asset and maximum allowed source amount to pay with
      # @param path [Array<Stellar::Asset>] the payment path to use
      #
      # @return [Stellar::Operation] the built operation
      def path_payment_strict_receive(destination:, amount:, with:, path: [], source_account: nil)
        raise ArgumentError unless destination.is_a?(KeyPair)

        dest_asset, dest_amount = get_asset_amount(amount)
        send_asset, send_max = get_asset_amount(with)

        op = PathPaymentStrictReceiveOp.new(
          destination: destination.muxed_account,
          dest_asset: dest_asset,
          dest_amount: dest_amount,
          send_asset: send_asset,
          send_max: send_max,
          path: path.map { |p| Asset(p) }
        )

        make(source_account: source_account, body: [:path_payment_strict_receive, op])
      end
      alias_method :path_payment, :path_payment_strict_receive

      # Path Payment Strict Receive operation builder.
      #
      # @param source_account [KeyPair, nil] the source account for the operation
      # @param destination [Stellar::KeyPair] the receiver of the payment
      # @param amount [Array] the destination asset and the minimum amount of destination asset to be received
      # @param with [Array] the source asset and amount to pay with
      # @param path [Array<Stellar::Asset>] the payment path to use
      #
      # @return [Stellar::Operation] the built operation
      def path_payment_strict_send(destination:, amount:, with:, path: [], source_account: nil)
        raise ArgumentError unless destination.is_a?(KeyPair)

        dest_asset, dest_min = get_asset_amount(amount)
        send_asset, send_amount = get_asset_amount(with)

        op = PathPaymentStrictSendOp.new(
          destination: destination.muxed_account,
          send_asset: send_asset,
          send_amount: send_amount,
          dest_asset: dest_asset,
          dest_min: dest_min,
          path: path.map { |p| Asset(p) }
        )

        make(source_account: source_account, body: [:path_payment_strict_send, op])
      end

      # Manage Sell Offer operation builder
      #
      # @param source_account [KeyPair, nil] the source account for the operation
      # @param selling [Asset] the asset to sell
      # @param buying [Asset] the asset to buy
      # @param amount [String, Numeric] the amount of asset to sell
      # @param price [String, Numeric, Price] the price of the selling asset in terms of buying asset
      # @param offer_id [Integer] the offer ID to modify (0 to create a new offer)
      #
      # @return [Operation] the built operation
      def manage_sell_offer(selling:, buying:, amount:, price:, offer_id: 0, source_account: nil)
        selling = Asset.send(*selling) if selling.is_a?(Array)
        buying = Asset.send(*buying) if buying.is_a?(Array)

        op = ManageSellOfferOp.new(
          buying: buying,
          selling: selling,
          amount: interpret_amount(amount),
          price: Price.from(price),
          offer_id: offer_id
        )

        make(source_account: source_account, body: [:manage_sell_offer, op])
      end

      # Manage Buy Offer operation builder
      #
      # @param source_account [KeyPair, nil] the source account for the operation
      # @param buying [Asset] the asset to buy
      # @param selling [Asset] the asset to sell
      # @param amount [String, Numeric] the amount of asset to buy
      # @param price [String, Numeric, Price] the price of the buying asset in terms of the selling asset
      # @param offer_id [Integer] the offer ID to modify (0 to create a new offer)
      #
      # @return [Operation] the built operation
      def manage_buy_offer(buying:, selling:, amount:, price:, offer_id: 0, source_account: nil)
        buying = Asset.send(*buying) if buying.is_a?(Array)
        selling = Asset.send(*selling) if selling.is_a?(Array)

        op = ManageBuyOfferOp.new(
          buying: buying,
          selling: selling,
          buy_amount: interpret_amount(amount),
          price: Price.from(price),
          offer_id: offer_id
        )

        make(source_account: source_account, body: [:manage_buy_offer, op])
      end

      # Create Passive Sell Offer operation builder
      #
      # @param source_account [KeyPair, nil] the source account for the operation
      # @param selling [Asset] the asset to sell
      # @param buying [Asset] the asset to buy
      # @param amount [String, Numeric] the amount of asset to sell
      # @param price [String, Numeric, Price] the price of the selling asset in terms of buying asset
      #
      # @return [Operation] the built operation
      def create_passive_sell_offer(selling:, buying:, amount:, price:, source_account: nil)
        selling = Asset.send(*selling) if selling.is_a?(Array)
        buying = Asset.send(*buying) if buying.is_a?(Array)

        op = CreatePassiveSellOfferOp.new(
          buying: buying,
          selling: selling,
          amount: interpret_amount(amount),
          price: Price.from(price)
        )

        make(source_account: source_account, body: [:create_passive_sell_offer, op])
      end

      # Liquidity Pool Deposit operation builder
      #
      # @param [Stellar::KeyPair] source_account the source account for the operation
      # @param [String] liquidity_pool_id the liquidity pool id as hexadecimal string
      # @param [String, Numeric] max_amount_a the maximum amount of asset A to deposit
      # @param [String, Numeric] max_amount_b the maximum amount of asset B to deposit
      # @param [String, Numeric, Stellar::Price] min_price the minimum valid price of asset A in terms of asset B
      # @param [String, Numeric, Stellar::Price] max_price the maximum valid price of asset A in terms of asset B
      #
      # @return [Stellar::Operation] the built operation
      def liquidity_pool_deposit(liquidity_pool_id:, max_amount_a:, max_amount_b:, min_price:, max_price:, source_account: nil)
        op = LiquidityPoolDepositOp.new(
          liquidity_pool_id: PoolID.from_xdr(liquidity_pool_id, :hex),
          max_amount_a: interpret_amount(max_amount_a),
          max_amount_b: interpret_amount(max_amount_b),
          min_price: Price.from(min_price),
          max_price: Price.from(max_price)
        )

        make(source_account: source_account, body: [:liquidity_pool_deposit, op])
      rescue XDR::ReadError
        raise ArgumentError, "invalid liquidity pool ID '#{balance_id}'"
      end

      # Liquidity Pool Withdraw operation builder
      #
      # @param [Stellar::KeyPair] source_account the source account for the operation
      # @param [String] liquidity_pool_id the liquidity pool id as hexadecimal string
      # @param [String, Numeric] amount the number of pool shares to withdraw
      # @param [String, Numeric] min_amount_a the minimum amount of asset A to withdraw
      # @param [String, Numeric] min_amount_b the minimum amount of asset B to withdraw
      #
      # @return [Stellar::Operation] the built operation
      def liquidity_pool_withdraw(liquidity_pool_id:, amount:, min_amount_a:, min_amount_b:, source_account: nil)
        op = LiquidityPoolWithdrawOp.new(
          liquidity_pool_id: PoolID.from_xdr(liquidity_pool_id, :hex),
          amount: interpret_amount(amount),
          min_amount_a: interpret_amount(min_amount_a),
          min_amount_b: interpret_amount(min_amount_b)
        )

        make(source_account: source_account, body: [:liquidity_pool_withdraw, op])
      rescue XDR::ReadError
        raise ArgumentError, "invalid liquidity pool ID '#{balance_id}'"
      end

      # Begin Sponsoring Future Reserves operation builder
      #
      # @param source_account [KeyPair, nil] the source account for the operation
      #
      # @return [Operation] the built operation
      def begin_sponsoring_future_reserves(sponsored:, source_account: nil)
        op = BeginSponsoringFutureReservesOp.new(
          sponsored_id: KeyPair(sponsored).account_id
        )

        make(source_account: source_account, body: [:begin_sponsoring_future_reserves, op])
      end

      # End Sponsoring Future Reserves operation builder
      #
      # @param source_account [KeyPair, nil] the source account for the operation
      #
      # @return [Operation] the built operation
      def end_sponsoring_future_reserves(source_account: nil)
        make(source_account: source_account, body: [:end_sponsoring_future_reserves])
      end

      # Revoke Sponsorship operation builder
      #
      # @param source_account [KeyPair, nil] the source account for the operation
      # @param sponsored [#to_keypair] owner of sponsored entry
      #
      # @return [Operation] the built operation
      def revoke_sponsorship(sponsored:, source_account: nil, **attributes)
        key_fields = attributes.slice(:offer_id, :data_name, :balance_id, :asset, :signer)
        raise ArgumentError, "conflicting attributes: #{key_fields.keys.join(", ")}" if key_fields.size > 1
        account_id = KeyPair(sponsored).account_id
        key, value = key_fields.first
        op = if key == :signer
          RevokeSponsorshipOp.signer(account_id: account_id, signer_key: SignerKey(value))
        else
          RevokeSponsorshipOp.ledger_key(LedgerKey.from(account_id: account_id, **key_fields))
        end
        make(source_account: source_account, body: [:revoke_sponsorship, op])
      end

      # Inflation operation builder
      #
      # @param [Stellar::KeyPair, nil] source_account the source account for the operation
      #
      # @return [Stellar::Operation] the built operation
      def inflation(source_account: nil)
        make(source_account: source_account, body: [:inflation])
      end

      private

      def get_asset_amount(values)
        amount = interpret_amount(values.last)
        asset = if values[0].is_a?(Stellar::Asset)
          values.first
        else
          Stellar::Asset.send(*values[0...-1])
        end

        [asset, amount]
      end

      def interpret_amount(amount)
        if amount.is_a?(Float)
          (amount * Stellar::ONE).floor
        else
          (BigDecimal(amount) * Stellar::ONE).floor
        end
      end
    end
  end
end

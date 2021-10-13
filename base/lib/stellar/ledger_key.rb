require "stellar/convert"
require "stellar/dsl"

module Stellar
  class LedgerKey
    class << self
      include Stellar::DSL

      def switch_for_arm(name)
        (@switch_by_arm ||= switches.invert).fetch(name)
      end

      def from(account_id:, **options)
        field, value = options.first
        case field
        when nil
          account(account_id: KeyPair(account_id).account_id)
        when :offer_id
          offer(seller_id: account_id, offer_id: Integer(value))
        when :data_name
          data(account_id: account_id, data_name: value.to_s)
        when :asset
          trust_line(account_id: account_id, asset: Asset(value).to_trust_line_asset)
        when :balance_id
          claimable_balance(balance_id: ClaimableBalanceID.v0(Stellar::Convert.from_hex(value.to_s)))
        when :liquidity_pool_id
          liquidity_pool(liquidity_pool_id: PoolID.from_xdr(value.to_s, :hex))
        else
          raise ArgumentError, "unknown option #{field} (not in :asset, :offer_id, :data_name, :balance_id)"
        end
      end
    end
  end
end

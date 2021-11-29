module Stellar::Horizon
  class ClaimableBalancePage < ResourcePage
    private

    def objectify(record)
      attributes = %i(id claimants asset amount)
      hash = record.to_hash.deep_symbolize_keys.slice(*attributes)
      ClaimableBalance(**hash)
    end
  end
end

require 'active_support/deprecation'

Stellar::Deprecation ||= ActiveSupport::Deprecation.new('next release', 'stellar-base')

class << Stellar::Operation
  alias_method :manage_offer, :manage_sell_offer
  alias_method :create_passive_offer, :create_passive_sell_offer

  deprecate deprecator: Stellar::Deprecation,
            manage_offer: :manage_sell_offer,
            create_passive_offer: :create_passive_sell_offer
end

class << Stellar::Transaction
  alias_method :manage_offer, :manage_sell_offer
  alias_method :create_passive_offer, :create_passive_sell_offer

  deprecate deprecator: Stellar::Deprecation,
            manage_offer: :manage_sell_offer,
            create_passive_offer: :create_passive_sell_offer
end


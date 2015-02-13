# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  autoload :TransactionType, "#{__dir__}/stellar/transaction_type"

  autoload :PaymentTx, "#{__dir__}/stellar/payment_tx"
  autoload :CreateOfferTx, "#{__dir__}/stellar/create_offer_tx"
  autoload :SetOptionsTx, "#{__dir__}/stellar/set_options_tx"
  autoload :ChangeTrustTx, "#{__dir__}/stellar/change_trust_tx"
  autoload :AllowTrustTx, "#{__dir__}/stellar/allow_trust_tx"
  autoload :Transaction, "#{__dir__}/stellar/transaction"
  autoload :TransactionEnvelope, "#{__dir__}/stellar/transaction_envelope"
  autoload :ClaimOfferAtom, "#{__dir__}/stellar/claim_offer_atom"

  module Payment
    autoload :PaymentResultCode, "#{__dir__}/stellar/payment/payment_result_code"

    autoload :SimplePaymentResult, "#{__dir__}/stellar/payment/simple_payment_result"
    autoload :SuccessMultiResult, "#{__dir__}/stellar/payment/success_multi_result"
    autoload :PaymentResult, "#{__dir__}/stellar/payment/payment_result"
  end
  module CreateOffer
    autoload :CreateOfferResultCode, "#{__dir__}/stellar/create_offer/create_offer_result_code"
    autoload :CreateOfferEffect, "#{__dir__}/stellar/create_offer/create_offer_effect"

    autoload :CreateOfferSuccessResult, "#{__dir__}/stellar/create_offer/create_offer_success_result"
    autoload :CreateOfferResult, "#{__dir__}/stellar/create_offer/create_offer_result"
  end
  module CancelOffer
    autoload :CancelOfferResultCode, "#{__dir__}/stellar/cancel_offer/cancel_offer_result_code"

    autoload :CancelOfferResult, "#{__dir__}/stellar/cancel_offer/cancel_offer_result"
  end
  module SetOption
    autoload :SetOptionsResultCode, "#{__dir__}/stellar/set_options/set_options_result_code"

    autoload :SetOptionsResult, "#{__dir__}/stellar/set_options/set_options_result"
  end
  module ChangeTrust
    autoload :ChangeTrustResultCode, "#{__dir__}/stellar/change_trust/change_trust_result_code"

    autoload :ChangeTrustResult, "#{__dir__}/stellar/change_trust/change_trust_result"
  end
  module AllowTrust
    autoload :AllowTrustResultCode, "#{__dir__}/stellar/allow_trust/allow_trust_result_code"

    autoload :AllowTrustResult, "#{__dir__}/stellar/allow_trust/allow_trust_result"
  end
  module AccountMerge
    autoload :AccountMergeResultCode, "#{__dir__}/stellar/account_merge/account_merge_result_code"

    autoload :AccountMergeResult, "#{__dir__}/stellar/account_merge/account_merge_result"
  end
  module Inflation
    autoload :InflationResultCode, "#{__dir__}/stellar/inflation/inflation_result_code"

    autoload :InflationPayout, "#{__dir__}/stellar/inflation/inflation_payout"
    autoload :InflationResult, "#{__dir__}/stellar/inflation/inflation_result"
  end

  autoload :TransactionResultCode, "#{__dir__}/stellar/transaction_result_code"

  autoload :TransactionResult, "#{__dir__}/stellar/transaction_result"
end

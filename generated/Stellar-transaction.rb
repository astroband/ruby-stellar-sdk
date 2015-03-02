# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  autoload :TransactionType, "#{File.dirname(__FILE__)}/stellar/transaction_type"

  autoload :PaymentTx, "#{File.dirname(__FILE__)}/stellar/payment_tx"
  autoload :CreateOfferTx, "#{File.dirname(__FILE__)}/stellar/create_offer_tx"
  autoload :SetSeqSlotTx, "#{File.dirname(__FILE__)}/stellar/set_seq_slot_tx"
  autoload :SetOptionsTx, "#{File.dirname(__FILE__)}/stellar/set_options_tx"
  autoload :ChangeTrustTx, "#{File.dirname(__FILE__)}/stellar/change_trust_tx"
  autoload :AllowTrustTx, "#{File.dirname(__FILE__)}/stellar/allow_trust_tx"
  autoload :Transaction, "#{File.dirname(__FILE__)}/stellar/transaction"
  autoload :TransactionEnvelope, "#{File.dirname(__FILE__)}/stellar/transaction_envelope"
  autoload :ClaimOfferAtom, "#{File.dirname(__FILE__)}/stellar/claim_offer_atom"

  module Payment
    autoload :PaymentResultCode, "#{File.dirname(__FILE__)}/stellar/payment/payment_result_code"

    autoload :SimplePaymentResult, "#{File.dirname(__FILE__)}/stellar/payment/simple_payment_result"
    autoload :SuccessMultiResult, "#{File.dirname(__FILE__)}/stellar/payment/success_multi_result"

    autoload :PaymentResult, "#{File.dirname(__FILE__)}/stellar/payment/payment_result"
  end
  module CreateOffer
    autoload :CreateOfferResultCode, "#{File.dirname(__FILE__)}/stellar/create_offer/create_offer_result_code"
    autoload :CreateOfferEffect, "#{File.dirname(__FILE__)}/stellar/create_offer/create_offer_effect"

    autoload :CreateOfferSuccessResult, "#{File.dirname(__FILE__)}/stellar/create_offer/create_offer_success_result"

    autoload :CreateOfferResult, "#{File.dirname(__FILE__)}/stellar/create_offer/create_offer_result"
  end
  module CancelOffer
    autoload :CancelOfferResultCode, "#{File.dirname(__FILE__)}/stellar/cancel_offer/cancel_offer_result_code"

    autoload :CancelOfferResult, "#{File.dirname(__FILE__)}/stellar/cancel_offer/cancel_offer_result"
  end
  module SetOptions
    autoload :SetOptionsResultCode, "#{File.dirname(__FILE__)}/stellar/set_options/set_options_result_code"

    autoload :SetOptionsResult, "#{File.dirname(__FILE__)}/stellar/set_options/set_options_result"
  end
  module ChangeTrust
    autoload :ChangeTrustResultCode, "#{File.dirname(__FILE__)}/stellar/change_trust/change_trust_result_code"

    autoload :ChangeTrustResult, "#{File.dirname(__FILE__)}/stellar/change_trust/change_trust_result"
  end
  module AllowTrust
    autoload :AllowTrustResultCode, "#{File.dirname(__FILE__)}/stellar/allow_trust/allow_trust_result_code"

    autoload :AllowTrustResult, "#{File.dirname(__FILE__)}/stellar/allow_trust/allow_trust_result"
  end
  module SetSeqSlot
    autoload :SetSeqSlotResultCode, "#{File.dirname(__FILE__)}/stellar/set_seq_slot/set_seq_slot_result_code"

    autoload :SetSeqSlotResult, "#{File.dirname(__FILE__)}/stellar/set_seq_slot/set_seq_slot_result"
  end
  module AccountMerge
    autoload :AccountMergeResultCode, "#{File.dirname(__FILE__)}/stellar/account_merge/account_merge_result_code"

    autoload :AccountMergeResult, "#{File.dirname(__FILE__)}/stellar/account_merge/account_merge_result"
  end
  module Inflation
    autoload :InflationResultCode, "#{File.dirname(__FILE__)}/stellar/inflation/inflation_result_code"

    autoload :InflationPayout, "#{File.dirname(__FILE__)}/stellar/inflation/inflation_payout"

    autoload :InflationResult, "#{File.dirname(__FILE__)}/stellar/inflation/inflation_result"
  end

  autoload :TransactionResultCode, "#{File.dirname(__FILE__)}/stellar/transaction_result_code"

  autoload :TransactionResult, "#{File.dirname(__FILE__)}/stellar/transaction_result"
end

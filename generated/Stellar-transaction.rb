# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  include XDR::Namespace

  autoload :TransactionType

  autoload :PaymentTx
  autoload :CreateOfferTx
  autoload :SetSeqSlotTx
  autoload :SetOptionsTx
  autoload :ChangeTrustTx
  autoload :AllowTrustTx
  autoload :Transaction
  autoload :TransactionEnvelope
  autoload :ClaimOfferAtom

  module Payment
    include XDR::Namespace

    autoload :PaymentResultCode

    autoload :SimplePaymentResult
    autoload :SuccessMultiResult

    autoload :PaymentResult
  end
  module CreateOffer
    include XDR::Namespace

    autoload :CreateOfferResultCode
    autoload :CreateOfferEffect

    autoload :CreateOfferSuccessResult

    autoload :CreateOfferResult
  end
  module CancelOffer
    include XDR::Namespace

    autoload :CancelOfferResultCode

    autoload :CancelOfferResult
  end
  module SetOptions
    include XDR::Namespace

    autoload :SetOptionsResultCode

    autoload :SetOptionsResult
  end
  module ChangeTrust
    include XDR::Namespace

    autoload :ChangeTrustResultCode

    autoload :ChangeTrustResult
  end
  module AllowTrust
    include XDR::Namespace

    autoload :AllowTrustResultCode

    autoload :AllowTrustResult
  end
  module SetSeqSlot
    include XDR::Namespace

    autoload :SetSeqSlotResultCode

    autoload :SetSeqSlotResult
  end
  module AccountMerge
    include XDR::Namespace

    autoload :AccountMergeResultCode

    autoload :AccountMergeResult
  end
  module Inflation
    include XDR::Namespace

    autoload :InflationResultCode

    autoload :InflationPayout

    autoload :InflationResult
  end

  autoload :TransactionResultCode

  autoload :TransactionResult
end

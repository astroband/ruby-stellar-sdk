# Automatically generated on 2015-03-30T09:46:31-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  include XDR::Namespace

  Signature = XDR::Opaque[64]
  Hash = XDR::Opaque[32]
  Uint256 = XDR::Opaque[32]
  Uint32 = XDR::UnsignedInt
  Uint64 = XDR::UnsignedHyper
  Value = XDR::VarOpaque[]
  Evidence = XDR::VarOpaque[]

  autoload :SCPBallot

  autoload :SCPStatementType

  autoload :SCPStatement
  autoload :SCPEnvelope
  autoload :SCPQuorumSet
end
module Stellar
  include XDR::Namespace

  autoload :LedgerEntryType

  autoload :Signer
  autoload :KeyValue

  autoload :AccountFlags

  autoload :AccountEntry
  autoload :TrustLineEntry
  autoload :OfferEntry

  autoload :LedgerEntry
end
module Stellar
  include XDR::Namespace

  autoload :LedgerHeader

  autoload :LedgerKey

  autoload :CLFType

  autoload :CLFEntry

  autoload :TransactionSet
  autoload :TransactionResultPair
  autoload :TransactionResultSet
  autoload :TransactionMeta
  autoload :TransactionHistoryEntry
  autoload :TransactionHistoryResultEntry
  autoload :LedgerHeaderHistoryEntry
end
module Stellar
  include XDR::Namespace

  autoload :StellarBallotValue
  autoload :StellarBallot
  autoload :Error
  autoload :Hello
  autoload :PeerAddress

  autoload :MessageType

  autoload :DontHave

  autoload :StellarMessage
end
module Stellar
  include XDR::Namespace

  autoload :DecoratedSignature

  autoload :OperationType

  autoload :PaymentOp
  autoload :CreateOfferOp
  autoload :SetOptionsOp
  autoload :ChangeTrustOp
  autoload :AllowTrustOp
  autoload :Operation
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

  autoload :OperationResultCode

  autoload :OperationResult

  autoload :TransactionResultCode

  autoload :TransactionResult
end
module Stellar
  include XDR::Namespace

  Uint512 = XDR::Opaque[64]
  Uint256 = XDR::Opaque[32]
  Uint64 = XDR::UnsignedHyper
  Int64 = XDR::Hyper
  Uint32 = XDR::UnsignedInt
  Int32 = XDR::Int
  AccountID = XDR::Opaque[32]
  Signature = XDR::Opaque[64]
  Hash = XDR::Opaque[32]
  Thresholds = XDR::Opaque[4]
  SequenceNumber = Uint64

  autoload :CurrencyType

  autoload :ISOCurrencyIssuer

  autoload :Currency

  autoload :Price
end
module Stellar
  include XDR::Namespace
end

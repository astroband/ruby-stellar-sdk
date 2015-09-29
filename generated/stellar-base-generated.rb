# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

module Stellar
  include XDR::Namespace

  Hash = XDR::Opaque[32]
  Uint256 = XDR::Opaque[32]
  Uint32 = XDR::UnsignedInt
  Int32 = XDR::Int
  Uint64 = XDR::UnsignedHyper
  Int64 = XDR::Hyper
  autoload :CryptoKeyType
  autoload :PublicKey
  Signature = XDR::VarOpaque[64]
  SignatureHint = XDR::Opaque[4]
  NodeID = PublicKey
  autoload :Curve25519Secret
  autoload :Curve25519Public
  autoload :HmacSha256Key
  autoload :HmacSha256Mac
end
module Stellar
  include XDR::Namespace

  AccountID = PublicKey
  Thresholds = XDR::Opaque[4]
  String32 = XDR::String[32]
  SequenceNumber = Uint64
  autoload :AssetType
  autoload :Asset
  autoload :Price
  autoload :ThresholdIndexes
  autoload :LedgerEntryType
  autoload :Signer
  autoload :AccountFlags
  autoload :AccountEntry
  autoload :TrustLineFlags
  autoload :TrustLineEntry
  autoload :OfferEntryFlags
  autoload :OfferEntry
  autoload :LedgerEntry
  autoload :EnvelopeType
end
module Stellar
  include XDR::Namespace

  autoload :DecoratedSignature
  autoload :OperationType
  autoload :CreateAccountOp
  autoload :PaymentOp
  autoload :PathPaymentOp
  autoload :ManageOfferOp
  autoload :CreatePassiveOfferOp
  autoload :SetOptionsOp
  autoload :ChangeTrustOp
  autoload :AllowTrustOp
  autoload :Operation
  autoload :MemoType
  autoload :Memo
  autoload :TimeBounds
  autoload :Transaction
  autoload :TransactionEnvelope
  autoload :ClaimOfferAtom
  autoload :CreateAccountResultCode
  autoload :CreateAccountResult
  autoload :PaymentResultCode
  autoload :PaymentResult
  autoload :PathPaymentResultCode
  autoload :SimplePaymentResult
  autoload :PathPaymentResult
  autoload :ManageOfferResultCode
  autoload :ManageOfferEffect
  autoload :ManageOfferSuccessResult
  autoload :ManageOfferResult
  autoload :SetOptionsResultCode
  autoload :SetOptionsResult
  autoload :ChangeTrustResultCode
  autoload :ChangeTrustResult
  autoload :AllowTrustResultCode
  autoload :AllowTrustResult
  autoload :AccountMergeResultCode
  autoload :AccountMergeResult
  autoload :InflationResultCode
  autoload :InflationPayout
  autoload :InflationResult
  autoload :OperationResultCode
  autoload :OperationResult
  autoload :TransactionResultCode
  autoload :TransactionResult
end
module Stellar
  include XDR::Namespace

  UpgradeType = XDR::VarOpaque[128]
  autoload :StellarValue
  autoload :LedgerHeader
  autoload :LedgerUpgradeType
  autoload :LedgerUpgrade
  autoload :LedgerKey
  autoload :BucketEntryType
  autoload :BucketEntry
  MAX_TX_PER_LEDGER = 5000
  autoload :TransactionSet
  autoload :TransactionResultPair
  autoload :TransactionResultSet
  autoload :TransactionHistoryEntry
  autoload :TransactionHistoryResultEntry
  autoload :LedgerHeaderHistoryEntry
  autoload :LedgerEntryChangeType
  autoload :LedgerEntryChange
  LedgerEntryChanges = XDR::VarArray[LedgerEntryChange]
  autoload :OperationMeta
  autoload :TransactionMeta
end
module Stellar
  include XDR::Namespace

  autoload :ErrorCode
  autoload :Error
  autoload :AuthCert
  autoload :Hello
  autoload :Auth
  autoload :IPAddrType
  autoload :PeerAddress
  autoload :MessageType
  autoload :DontHave
  autoload :StellarMessage
  autoload :AuthenticatedMessage
end
module Stellar
  include XDR::Namespace

  Value = XDR::VarOpaque[]
  autoload :SCPBallot
  autoload :SCPStatementType
  autoload :SCPNomination
  autoload :SCPStatement
  autoload :SCPEnvelope
  autoload :SCPQuorumSet
end

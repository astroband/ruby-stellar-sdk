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
  autoload :PublicKeyType
  autoload :SignerKeyType
  autoload :PublicKey
  autoload :SignerKey
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
  String64 = XDR::String[64]
  SequenceNumber = Int64
  DataValue = XDR::VarOpaque[64]
  autoload :AssetType
  autoload :Asset
  autoload :Price
  autoload :Liabilities
  autoload :ThresholdIndexes
  autoload :LedgerEntryType
  autoload :Signer
  autoload :AccountFlags
  MASK_ACCOUNT_FLAGS = 0x7
  autoload :AccountEntry
  autoload :TrustLineFlags
  MASK_TRUSTLINE_FLAGS = 1
  autoload :TrustLineEntry
  autoload :OfferEntryFlags
  MASK_OFFERENTRY_FLAGS = 1
  autoload :OfferEntry
  autoload :DataEntry
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
  autoload :ManageDataOp
  autoload :BumpSequenceOp
  autoload :Operation
  autoload :MemoType
  autoload :Memo
  autoload :TimeBounds
  autoload :Transaction
  autoload :TransactionSignaturePayload
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
  autoload :ManageDataResultCode
  autoload :ManageDataResult
  autoload :BumpSequenceResultCode
  autoload :BumpSequenceResult
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
  autoload :TransactionSet
  autoload :TransactionResultPair
  autoload :TransactionResultSet
  autoload :TransactionHistoryEntry
  autoload :TransactionHistoryResultEntry
  autoload :LedgerHeaderHistoryEntry
  autoload :LedgerSCPMessages
  autoload :SCPHistoryEntryV0
  autoload :SCPHistoryEntry
  autoload :LedgerEntryChangeType
  autoload :LedgerEntryChange
  LedgerEntryChanges = XDR::VarArray[LedgerEntryChange]
  autoload :OperationMeta
  autoload :TransactionMetaV1
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

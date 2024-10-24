// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

namespace stellar
{

typedef opaque Hash[32];
typedef opaque uint256[32];

typedef unsigned int uint32;
typedef int int32;

typedef unsigned hyper uint64;
typedef hyper int64;

typedef uint64 TimePoint;
typedef uint64 Duration;

// An ExtensionPoint is always marshaled as a 32-bit 0 value.  At a
// later point, it can be replaced by a different union so as to
// extend a structure.
union ExtensionPoint switch (int v)
{
case 0:
    void;
};

enum CryptoKeyType
{
    KEY_TYPE_ED25519 = 0,
    KEY_TYPE_PRE_AUTH_TX = 1,
    KEY_TYPE_HASH_X = 2,
    KEY_TYPE_ED25519_SIGNED_PAYLOAD = 3,
    // MUXED enum values for supported type are derived from the enum values
    // above by ORing them with 0x100
    KEY_TYPE_MUXED_ED25519 = 0x100
};

enum PublicKeyType
{
    PUBLIC_KEY_TYPE_ED25519 = KEY_TYPE_ED25519
};

enum SignerKeyType
{
    SIGNER_KEY_TYPE_ED25519 = KEY_TYPE_ED25519,
    SIGNER_KEY_TYPE_PRE_AUTH_TX = KEY_TYPE_PRE_AUTH_TX,
    SIGNER_KEY_TYPE_HASH_X = KEY_TYPE_HASH_X,
    SIGNER_KEY_TYPE_ED25519_SIGNED_PAYLOAD = KEY_TYPE_ED25519_SIGNED_PAYLOAD
};

union PublicKey switch (PublicKeyType type)
{
case PUBLIC_KEY_TYPE_ED25519:
    uint256 ed25519;
};

union SignerKey switch (SignerKeyType type)
{
case SIGNER_KEY_TYPE_ED25519:
    uint256 ed25519;
case SIGNER_KEY_TYPE_PRE_AUTH_TX:
    /* SHA-256 Hash of TransactionSignaturePayload structure */
    uint256 preAuthTx;
case SIGNER_KEY_TYPE_HASH_X:
    /* Hash of random 256 bit preimage X */
    uint256 hashX;
case SIGNER_KEY_TYPE_ED25519_SIGNED_PAYLOAD:
    struct
    {
        /* Public key that must sign the payload. */
        uint256 ed25519;
        /* Payload to be raw signed by ed25519. */
        opaque payload<64>;
    } ed25519SignedPayload;
};

// variable size as the size depends on the signature scheme used
typedef opaque Signature<64>;

typedef opaque SignatureHint[4];

typedef PublicKey NodeID;
typedef PublicKey AccountID;

struct Curve25519Secret
{
    opaque key[32];
};

struct Curve25519Public
{
    opaque key[32];
};

struct HmacSha256Key
{
    opaque key[32];
};

struct HmacSha256Mac
{
    opaque mac[32];
};
}

// Copyright 2022 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

% #include "xdr/Stellar-types.h"
namespace stellar
{

// We fix a maximum of 128 value types in the system for two reasons: we want to
// keep the codes relatively small (<= 8 bits) when bit-packing values into a
// u64 at the environment interface level, so that we keep many bits for
// payloads (small strings, small numeric values, object handles); and then we
// actually want to go one step further and ensure (for code-size) that our
// codes fit in a single ULEB128-code byte, which means we can only use 7 bits.
//
// We also reserve several type codes from this space because we want to _reuse_
// the SCValType codes at the environment interface level (or at least not
// exceed its number-space) but there are more types at that level, assigned to
// optimizations/special case representations of values abstract at this level.

enum SCValType
{
    SCV_BOOL = 0,
    SCV_VOID = 1,
    SCV_ERROR = 2,

    // 32 bits is the smallest type in WASM or XDR; no need for u8/u16.
    SCV_U32 = 3,
    SCV_I32 = 4,

    // 64 bits is naturally supported by both WASM and XDR also.
    SCV_U64 = 5,
    SCV_I64 = 6,

    // Time-related u64 subtypes with their own functions and formatting.
    SCV_TIMEPOINT = 7,
    SCV_DURATION = 8,

    // 128 bits is naturally supported by Rust and we use it for Soroban
    // fixed-point arithmetic prices / balances / similar "quantities". These
    // are represented in XDR as a pair of 2 u64s.
    SCV_U128 = 9,
    SCV_I128 = 10,

    // 256 bits is the size of sha256 output, ed25519 keys, and the EVM machine
    // word, so for interop use we include this even though it requires a small
    // amount of Rust guest and/or host library code.
    SCV_U256 = 11,
    SCV_I256 = 12,

    // Bytes come in 3 flavors, 2 of which have meaningfully different
    // formatting and validity-checking / domain-restriction.
    SCV_BYTES = 13,
    SCV_STRING = 14,
    SCV_SYMBOL = 15,

    // Vecs and maps are just polymorphic containers of other ScVals.
    SCV_VEC = 16,
    SCV_MAP = 17,

    // Address is the universal identifier for contracts and classic
    // accounts.
    SCV_ADDRESS = 18,

    // The following are the internal SCVal variants that are not
    // exposed to the contracts. 
    SCV_CONTRACT_INSTANCE = 19,

    // SCV_LEDGER_KEY_CONTRACT_INSTANCE and SCV_LEDGER_KEY_NONCE are unique
    // symbolic SCVals used as the key for ledger entries for a contract's
    // instance and an address' nonce, respectively.
    SCV_LEDGER_KEY_CONTRACT_INSTANCE = 20,
    SCV_LEDGER_KEY_NONCE = 21
};

enum SCErrorType
{
    SCE_CONTRACT = 0,          // Contract-specific, user-defined codes.
    SCE_WASM_VM = 1,           // Errors while interpreting WASM bytecode.
    SCE_CONTEXT = 2,           // Errors in the contract's host context.
    SCE_STORAGE = 3,           // Errors accessing host storage.
    SCE_OBJECT = 4,            // Errors working with host objects.
    SCE_CRYPTO = 5,            // Errors in cryptographic operations.
    SCE_EVENTS = 6,            // Errors while emitting events.
    SCE_BUDGET = 7,            // Errors relating to budget limits.
    SCE_VALUE = 8,             // Errors working with host values or SCVals.
    SCE_AUTH = 9               // Errors from the authentication subsystem.
};

enum SCErrorCode
{
    SCEC_ARITH_DOMAIN = 0,      // Some arithmetic was undefined (overflow, divide-by-zero).
    SCEC_INDEX_BOUNDS = 1,      // Something was indexed beyond its bounds.
    SCEC_INVALID_INPUT = 2,     // User provided some otherwise-bad data.
    SCEC_MISSING_VALUE = 3,     // Some value was required but not provided.
    SCEC_EXISTING_VALUE = 4,    // Some value was provided where not allowed.
    SCEC_EXCEEDED_LIMIT = 5,    // Some arbitrary limit -- gas or otherwise -- was hit.
    SCEC_INVALID_ACTION = 6,    // Data was valid but action requested was not.
    SCEC_INTERNAL_ERROR = 7,    // The host detected an error in its own logic.
    SCEC_UNEXPECTED_TYPE = 8,   // Some type wasn't as expected.
    SCEC_UNEXPECTED_SIZE = 9    // Something's size wasn't as expected.
};

// Smart contract errors are split into a type (SCErrorType) and a code. When an
// error is of type SCE_CONTRACT it carries a user-defined uint32 code that
// Soroban assigns no specific meaning to. In all other cases, the type
// specifies a subsystem of the Soroban host where the error originated, and the
// accompanying code is an SCErrorCode, each of which specifies a slightly more
// precise class of errors within that subsystem.
//
// Error types and codes are not maximally precise; there is a tradeoff between
// precision and flexibility in the implementation, and the granularity here is
// chosen to be adequate for most purposes while not placing a burden on future
// system evolution and maintenance. When additional precision is needed for
// debugging, Soroban can be run with diagnostic events enabled.

union SCError switch (SCErrorType type)
{
case SCE_CONTRACT:
    uint32 contractCode;
case SCE_WASM_VM:
case SCE_CONTEXT:
case SCE_STORAGE:
case SCE_OBJECT:
case SCE_CRYPTO:
case SCE_EVENTS:
case SCE_BUDGET:
case SCE_VALUE:
case SCE_AUTH:
    SCErrorCode code;
};

struct UInt128Parts {
    uint64 hi;
    uint64 lo;
};

// A signed int128 has a high sign bit and 127 value bits. We break it into a
// signed high int64 (that carries the sign bit and the high 63 value bits) and
// a low unsigned uint64 that carries the low 64 bits. This will sort in
// generated code in the same order the underlying int128 sorts.
struct Int128Parts {
    int64 hi;
    uint64 lo;
};

struct UInt256Parts {
    uint64 hi_hi;
    uint64 hi_lo;
    uint64 lo_hi;
    uint64 lo_lo;
};

// A signed int256 has a high sign bit and 255 value bits. We break it into a
// signed high int64 (that carries the sign bit and the high 63 value bits) and
// three low unsigned `uint64`s that carry the lower bits. This will sort in
// generated code in the same order the underlying int256 sorts.
struct Int256Parts {
    int64 hi_hi;
    uint64 hi_lo;
    uint64 lo_hi;
    uint64 lo_lo;
};

enum ContractExecutableType
{
    CONTRACT_EXECUTABLE_WASM = 0,
    CONTRACT_EXECUTABLE_STELLAR_ASSET = 1
};

union ContractExecutable switch (ContractExecutableType type)
{
case CONTRACT_EXECUTABLE_WASM:
    Hash wasm_hash;
case CONTRACT_EXECUTABLE_STELLAR_ASSET:
    void;
};

enum SCAddressType
{
    SC_ADDRESS_TYPE_ACCOUNT = 0,
    SC_ADDRESS_TYPE_CONTRACT = 1
};

union SCAddress switch (SCAddressType type)
{
case SC_ADDRESS_TYPE_ACCOUNT:
    AccountID accountId;
case SC_ADDRESS_TYPE_CONTRACT:
    Hash contractId;
};

%struct SCVal;
%struct SCMapEntry;

const SCSYMBOL_LIMIT = 32;

typedef SCVal SCVec<>;
typedef SCMapEntry SCMap<>;

typedef opaque SCBytes<>;
typedef string SCString<>;
typedef string SCSymbol<SCSYMBOL_LIMIT>;

struct SCNonceKey {
    int64 nonce;
};

struct SCContractInstance {
    ContractExecutable executable;
    SCMap* storage;
};

union SCVal switch (SCValType type)
{

case SCV_BOOL:
    bool b;
case SCV_VOID:
    void;
case SCV_ERROR:
    SCError error;

case SCV_U32:
    uint32 u32;
case SCV_I32:
    int32 i32;

case SCV_U64:
    uint64 u64;
case SCV_I64:
    int64 i64;
case SCV_TIMEPOINT:
    TimePoint timepoint;
case SCV_DURATION:
    Duration duration;

case SCV_U128:
    UInt128Parts u128;
case SCV_I128:
    Int128Parts i128;

case SCV_U256:
    UInt256Parts u256;
case SCV_I256:
    Int256Parts i256;

case SCV_BYTES:
    SCBytes bytes;
case SCV_STRING:
    SCString str;
case SCV_SYMBOL:
    SCSymbol sym;

// Vec and Map are recursive so need to live
// behind an option, due to xdrpp limitations.
case SCV_VEC:
    SCVec *vec;
case SCV_MAP:
    SCMap *map;

case SCV_ADDRESS:
    SCAddress address;

// Special SCVals reserved for system-constructed contract-data
// ledger keys, not generally usable elsewhere.
case SCV_LEDGER_KEY_CONTRACT_INSTANCE:
    void;
case SCV_LEDGER_KEY_NONCE:
    SCNonceKey nonce_key;

case SCV_CONTRACT_INSTANCE:
    SCContractInstance instance;
};

struct SCMapEntry
{
    SCVal key;
    SCVal val;
};

}

%#include "xdr/Stellar-types.h"

namespace stellar {
// General “Soroban execution lane” settings
struct ConfigSettingContractExecutionLanesV0
{
    // maximum number of Soroban transactions per ledger
    uint32 ledgerMaxTxCount;
};

// "Compute" settings for contracts (instructions and memory).
struct ConfigSettingContractComputeV0
{
    // Maximum instructions per ledger
    int64 ledgerMaxInstructions;
    // Maximum instructions per transaction
    int64 txMaxInstructions;
    // Cost of 10000 instructions
    int64 feeRatePerInstructionsIncrement;

    // Memory limit per transaction. Unlike instructions, there is no fee
    // for memory, just the limit.
    uint32 txMemoryLimit;
};

// Ledger access settings for contracts.
struct ConfigSettingContractLedgerCostV0
{
    // Maximum number of ledger entry read operations per ledger
    uint32 ledgerMaxReadLedgerEntries;
    // Maximum number of bytes that can be read per ledger
    uint32 ledgerMaxReadBytes;
    // Maximum number of ledger entry write operations per ledger
    uint32 ledgerMaxWriteLedgerEntries;
    // Maximum number of bytes that can be written per ledger
    uint32 ledgerMaxWriteBytes;

    // Maximum number of ledger entry read operations per transaction
    uint32 txMaxReadLedgerEntries;
    // Maximum number of bytes that can be read per transaction
    uint32 txMaxReadBytes;
    // Maximum number of ledger entry write operations per transaction
    uint32 txMaxWriteLedgerEntries;
    // Maximum number of bytes that can be written per transaction
    uint32 txMaxWriteBytes;

    int64 feeReadLedgerEntry;  // Fee per ledger entry read
    int64 feeWriteLedgerEntry; // Fee per ledger entry write

    int64 feeRead1KB;  // Fee for reading 1KB

    // The following parameters determine the write fee per 1KB.
    // Write fee grows linearly until bucket list reaches this size
    int64 bucketListTargetSizeBytes;
    // Fee per 1KB write when the bucket list is empty
    int64 writeFee1KBBucketListLow;
    // Fee per 1KB write when the bucket list has reached `bucketListTargetSizeBytes` 
    int64 writeFee1KBBucketListHigh;
    // Write fee multiplier for any additional data past the first `bucketListTargetSizeBytes`
    uint32 bucketListWriteFeeGrowthFactor;
};

// Historical data (pushed to core archives) settings for contracts.
struct ConfigSettingContractHistoricalDataV0
{
    int64 feeHistorical1KB; // Fee for storing 1KB in archives
};

// Contract event-related settings.
struct ConfigSettingContractEventsV0
{
    // Maximum size of events that a contract call can emit.
    uint32 txMaxContractEventsSizeBytes;
    // Fee for generating 1KB of contract events.
    int64 feeContractEvents1KB;
};

// Bandwidth related data settings for contracts.
// We consider bandwidth to only be consumed by the transaction envelopes, hence
// this concerns only transaction sizes.
struct ConfigSettingContractBandwidthV0
{
    // Maximum sum of all transaction sizes in the ledger in bytes
    uint32 ledgerMaxTxsSizeBytes;
    // Maximum size in bytes for a transaction
    uint32 txMaxSizeBytes;

    // Fee for 1 KB of transaction size
    int64 feeTxSize1KB;
};

enum ContractCostType {
    // Cost of running 1 wasm instruction
    WasmInsnExec = 0,
    // Cost of allocating a slice of memory (in bytes)
    MemAlloc = 1,
    // Cost of copying a slice of bytes into a pre-allocated memory
    MemCpy = 2,
    // Cost of comparing two slices of memory
    MemCmp = 3,
    // Cost of a host function dispatch, not including the actual work done by
    // the function nor the cost of VM invocation machinary
    DispatchHostFunction = 4,
    // Cost of visiting a host object from the host object storage. Exists to 
    // make sure some baseline cost coverage, i.e. repeatly visiting objects
    // by the guest will always incur some charges.
    VisitObject = 5,
    // Cost of serializing an xdr object to bytes
    ValSer = 6,
    // Cost of deserializing an xdr object from bytes
    ValDeser = 7,
    // Cost of computing the sha256 hash from bytes
    ComputeSha256Hash = 8,
    // Cost of computing the ed25519 pubkey from bytes
    ComputeEd25519PubKey = 9,
    // Cost of verifying ed25519 signature of a payload.
    VerifyEd25519Sig = 10,
    // Cost of instantiation a VM from wasm bytes code.
    VmInstantiation = 11,
    // Cost of instantiation a VM from a cached state.
    VmCachedInstantiation = 12,
    // Cost of invoking a function on the VM. If the function is a host function,
    // additional cost will be covered by `DispatchHostFunction`.
    InvokeVmFunction = 13,
    // Cost of computing a keccak256 hash from bytes.
    ComputeKeccak256Hash = 14,
    // Cost of computing an ECDSA secp256k1 signature from bytes.
    ComputeEcdsaSecp256k1Sig = 15,
    // Cost of recovering an ECDSA secp256k1 key from a signature.
    RecoverEcdsaSecp256k1Key = 16,
    // Cost of int256 addition (`+`) and subtraction (`-`) operations
    Int256AddSub = 17,
    // Cost of int256 multiplication (`*`) operation
    Int256Mul = 18,
    // Cost of int256 division (`/`) operation
    Int256Div = 19,
    // Cost of int256 power (`exp`) operation
    Int256Pow = 20,
    // Cost of int256 shift (`shl`, `shr`) operation
    Int256Shift = 21,
    // Cost of drawing random bytes using a ChaCha20 PRNG
    ChaCha20DrawBytes = 22
};

struct ContractCostParamEntry {
    // use `ext` to add more terms (e.g. higher order polynomials) in the future
    ExtensionPoint ext;

    int64 constTerm;
    int64 linearTerm;
};

struct StateArchivalSettings {
    uint32 maxEntryTTL;
    uint32 minTemporaryTTL;
    uint32 minPersistentTTL;

    // rent_fee = wfee_rate_average / rent_rate_denominator_for_type
    int64 persistentRentRateDenominator;
    int64 tempRentRateDenominator;

    // max number of entries that emit archival meta in a single ledger
    uint32 maxEntriesToArchive;

    // Number of snapshots to use when calculating average BucketList size
    uint32 bucketListSizeWindowSampleSize;

    // Maximum number of bytes that we scan for eviction per ledger
    uint64 evictionScanSize;

    // Lowest BucketList level to be scanned to evict entries
    uint32 startingEvictionScanLevel;
};

struct EvictionIterator {
    uint32 bucketListLevel;
    bool isCurrBucket;
    uint64 bucketFileOffset;
};

// limits the ContractCostParams size to 20kB
const CONTRACT_COST_COUNT_LIMIT = 1024;

typedef ContractCostParamEntry ContractCostParams<CONTRACT_COST_COUNT_LIMIT>;

// Identifiers of all the network settings.
enum ConfigSettingID
{
    CONFIG_SETTING_CONTRACT_MAX_SIZE_BYTES = 0,
    CONFIG_SETTING_CONTRACT_COMPUTE_V0 = 1,
    CONFIG_SETTING_CONTRACT_LEDGER_COST_V0 = 2,
    CONFIG_SETTING_CONTRACT_HISTORICAL_DATA_V0 = 3,
    CONFIG_SETTING_CONTRACT_EVENTS_V0 = 4,
    CONFIG_SETTING_CONTRACT_BANDWIDTH_V0 = 5,
    CONFIG_SETTING_CONTRACT_COST_PARAMS_CPU_INSTRUCTIONS = 6,
    CONFIG_SETTING_CONTRACT_COST_PARAMS_MEMORY_BYTES = 7,
    CONFIG_SETTING_CONTRACT_DATA_KEY_SIZE_BYTES = 8,
    CONFIG_SETTING_CONTRACT_DATA_ENTRY_SIZE_BYTES = 9,
    CONFIG_SETTING_STATE_ARCHIVAL = 10,
    CONFIG_SETTING_CONTRACT_EXECUTION_LANES = 11,
    CONFIG_SETTING_BUCKETLIST_SIZE_WINDOW = 12,
    CONFIG_SETTING_EVICTION_ITERATOR = 13
};

union ConfigSettingEntry switch (ConfigSettingID configSettingID)
{
case CONFIG_SETTING_CONTRACT_MAX_SIZE_BYTES:
    uint32 contractMaxSizeBytes;
case CONFIG_SETTING_CONTRACT_COMPUTE_V0:
    ConfigSettingContractComputeV0 contractCompute;
case CONFIG_SETTING_CONTRACT_LEDGER_COST_V0:
    ConfigSettingContractLedgerCostV0 contractLedgerCost;
case CONFIG_SETTING_CONTRACT_HISTORICAL_DATA_V0:
    ConfigSettingContractHistoricalDataV0 contractHistoricalData;
case CONFIG_SETTING_CONTRACT_EVENTS_V0:
    ConfigSettingContractEventsV0 contractEvents;
case CONFIG_SETTING_CONTRACT_BANDWIDTH_V0:
    ConfigSettingContractBandwidthV0 contractBandwidth;
case CONFIG_SETTING_CONTRACT_COST_PARAMS_CPU_INSTRUCTIONS:
    ContractCostParams contractCostParamsCpuInsns;
case CONFIG_SETTING_CONTRACT_COST_PARAMS_MEMORY_BYTES:
    ContractCostParams contractCostParamsMemBytes;
case CONFIG_SETTING_CONTRACT_DATA_KEY_SIZE_BYTES:
    uint32 contractDataKeySizeBytes;
case CONFIG_SETTING_CONTRACT_DATA_ENTRY_SIZE_BYTES:
    uint32 contractDataEntrySizeBytes;
case CONFIG_SETTING_STATE_ARCHIVAL:
    StateArchivalSettings stateArchivalSettings;
case CONFIG_SETTING_CONTRACT_EXECUTION_LANES:
    ConfigSettingContractExecutionLanesV0 contractExecutionLanes;
case CONFIG_SETTING_BUCKETLIST_SIZE_WINDOW:
    uint64 bucketListSizeWindow<>;
case CONFIG_SETTING_EVICTION_ITERATOR:
    EvictionIterator evictionIterator;
};
}

// Copyright 2022 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

// The contract spec XDR is highly experimental, incomplete, and still being
// iterated on. Breaking changes expected.

% #include "xdr/Stellar-types.h"
namespace stellar
{

enum SCEnvMetaKind
{
    SC_ENV_META_KIND_INTERFACE_VERSION = 0
};

union SCEnvMetaEntry switch (SCEnvMetaKind kind)
{
case SC_ENV_META_KIND_INTERFACE_VERSION:
    uint64 interfaceVersion;
};

}

// Copyright 2022 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

// The contract meta XDR is highly experimental, incomplete, and still being
// iterated on. Breaking changes expected.

% #include "xdr/Stellar-types.h"
namespace stellar
{

struct SCMetaV0
{
    string key<>;
    string val<>;
};

enum SCMetaKind
{
    SC_META_V0 = 0
};

union SCMetaEntry switch (SCMetaKind kind)
{
case SC_META_V0:
    SCMetaV0 v0;
};

}

// Copyright 2022 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

// The contract Contractspec XDR is highly experimental, incomplete, and still being
// iterated on. Breaking changes expected.

% #include "xdr/Stellar-types.h"
% #include "xdr/Stellar-contract.h"
namespace stellar
{

const SC_SPEC_DOC_LIMIT = 1024;

enum SCSpecType
{
    SC_SPEC_TYPE_VAL = 0,

    // Types with no parameters.
    SC_SPEC_TYPE_BOOL = 1,
    SC_SPEC_TYPE_VOID = 2,
    SC_SPEC_TYPE_ERROR = 3,
    SC_SPEC_TYPE_U32 = 4,
    SC_SPEC_TYPE_I32 = 5,
    SC_SPEC_TYPE_U64 = 6,
    SC_SPEC_TYPE_I64 = 7,
    SC_SPEC_TYPE_TIMEPOINT = 8,
    SC_SPEC_TYPE_DURATION = 9,
    SC_SPEC_TYPE_U128 = 10,
    SC_SPEC_TYPE_I128 = 11,
    SC_SPEC_TYPE_U256 = 12,
    SC_SPEC_TYPE_I256 = 13,
    SC_SPEC_TYPE_BYTES = 14,
    SC_SPEC_TYPE_STRING = 16,
    SC_SPEC_TYPE_SYMBOL = 17,
    SC_SPEC_TYPE_ADDRESS = 19,

    // Types with parameters.
    SC_SPEC_TYPE_OPTION = 1000,
    SC_SPEC_TYPE_RESULT = 1001,
    SC_SPEC_TYPE_VEC = 1002,
    SC_SPEC_TYPE_MAP = 1004,
    SC_SPEC_TYPE_TUPLE = 1005,
    SC_SPEC_TYPE_BYTES_N = 1006,

    // User defined types.
    SC_SPEC_TYPE_UDT = 2000
};

struct SCSpecTypeOption
{
    SCSpecTypeDef valueType;
};

struct SCSpecTypeResult
{
    SCSpecTypeDef okType;
    SCSpecTypeDef errorType;
};

struct SCSpecTypeVec
{
    SCSpecTypeDef elementType;
};

struct SCSpecTypeMap
{
    SCSpecTypeDef keyType;
    SCSpecTypeDef valueType;
};

struct SCSpecTypeTuple
{
    SCSpecTypeDef valueTypes<12>;
};

struct SCSpecTypeBytesN
{
    uint32 n;
};

struct SCSpecTypeUDT
{
    string name<60>;
};

union SCSpecTypeDef switch (SCSpecType type)
{
case SC_SPEC_TYPE_VAL:
case SC_SPEC_TYPE_BOOL:
case SC_SPEC_TYPE_VOID:
case SC_SPEC_TYPE_ERROR:
case SC_SPEC_TYPE_U32:
case SC_SPEC_TYPE_I32:
case SC_SPEC_TYPE_U64:
case SC_SPEC_TYPE_I64:
case SC_SPEC_TYPE_TIMEPOINT:
case SC_SPEC_TYPE_DURATION:
case SC_SPEC_TYPE_U128:
case SC_SPEC_TYPE_I128:
case SC_SPEC_TYPE_U256:
case SC_SPEC_TYPE_I256:
case SC_SPEC_TYPE_BYTES:
case SC_SPEC_TYPE_STRING:
case SC_SPEC_TYPE_SYMBOL:
case SC_SPEC_TYPE_ADDRESS:
    void;
case SC_SPEC_TYPE_OPTION:
    SCSpecTypeOption option;
case SC_SPEC_TYPE_RESULT:
    SCSpecTypeResult result;
case SC_SPEC_TYPE_VEC:
    SCSpecTypeVec vec;
case SC_SPEC_TYPE_MAP:
    SCSpecTypeMap map;
case SC_SPEC_TYPE_TUPLE:
    SCSpecTypeTuple tuple;
case SC_SPEC_TYPE_BYTES_N:
    SCSpecTypeBytesN bytesN;
case SC_SPEC_TYPE_UDT:
    SCSpecTypeUDT udt;
};

struct SCSpecUDTStructFieldV0
{
    string doc<SC_SPEC_DOC_LIMIT>;
    string name<30>;
    SCSpecTypeDef type;
};

struct SCSpecUDTStructV0
{
    string doc<SC_SPEC_DOC_LIMIT>;
    string lib<80>;
    string name<60>;
    SCSpecUDTStructFieldV0 fields<40>;
};

struct SCSpecUDTUnionCaseVoidV0
{
    string doc<SC_SPEC_DOC_LIMIT>;
    string name<60>;
};

struct SCSpecUDTUnionCaseTupleV0
{
    string doc<SC_SPEC_DOC_LIMIT>;
    string name<60>;
    SCSpecTypeDef type<12>;
};

enum SCSpecUDTUnionCaseV0Kind
{
    SC_SPEC_UDT_UNION_CASE_VOID_V0 = 0,
    SC_SPEC_UDT_UNION_CASE_TUPLE_V0 = 1
};

union SCSpecUDTUnionCaseV0 switch (SCSpecUDTUnionCaseV0Kind kind)
{
case SC_SPEC_UDT_UNION_CASE_VOID_V0:
    SCSpecUDTUnionCaseVoidV0 voidCase;
case SC_SPEC_UDT_UNION_CASE_TUPLE_V0:
    SCSpecUDTUnionCaseTupleV0 tupleCase;
};

struct SCSpecUDTUnionV0
{
    string doc<SC_SPEC_DOC_LIMIT>;
    string lib<80>;
    string name<60>;
    SCSpecUDTUnionCaseV0 cases<50>;
};

struct SCSpecUDTEnumCaseV0
{
    string doc<SC_SPEC_DOC_LIMIT>;
    string name<60>;
    uint32 value;
};

struct SCSpecUDTEnumV0
{
    string doc<SC_SPEC_DOC_LIMIT>;
    string lib<80>;
    string name<60>;
    SCSpecUDTEnumCaseV0 cases<50>;
};

struct SCSpecUDTErrorEnumCaseV0
{
    string doc<SC_SPEC_DOC_LIMIT>;
    string name<60>;
    uint32 value;
};

struct SCSpecUDTErrorEnumV0
{
    string doc<SC_SPEC_DOC_LIMIT>;
    string lib<80>;
    string name<60>;
    SCSpecUDTErrorEnumCaseV0 cases<50>;
};

struct SCSpecFunctionInputV0
{
    string doc<SC_SPEC_DOC_LIMIT>;
    string name<30>;
    SCSpecTypeDef type;
};

struct SCSpecFunctionV0
{
    string doc<SC_SPEC_DOC_LIMIT>;
    SCSymbol name;
    SCSpecFunctionInputV0 inputs<10>;
    SCSpecTypeDef outputs<1>;
};

enum SCSpecEntryKind
{
    SC_SPEC_ENTRY_FUNCTION_V0 = 0,
    SC_SPEC_ENTRY_UDT_STRUCT_V0 = 1,
    SC_SPEC_ENTRY_UDT_UNION_V0 = 2,
    SC_SPEC_ENTRY_UDT_ENUM_V0 = 3,
    SC_SPEC_ENTRY_UDT_ERROR_ENUM_V0 = 4
};

union SCSpecEntry switch (SCSpecEntryKind kind)
{
case SC_SPEC_ENTRY_FUNCTION_V0:
    SCSpecFunctionV0 functionV0;
case SC_SPEC_ENTRY_UDT_STRUCT_V0:
    SCSpecUDTStructV0 udtStructV0;
case SC_SPEC_ENTRY_UDT_UNION_V0:
    SCSpecUDTUnionV0 udtUnionV0;
case SC_SPEC_ENTRY_UDT_ENUM_V0:
    SCSpecUDTEnumV0 udtEnumV0;
case SC_SPEC_ENTRY_UDT_ERROR_ENUM_V0:
    SCSpecUDTErrorEnumV0 udtErrorEnumV0;
};

}

// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"
%#include "xdr/Stellar-contract.h"
%#include "xdr/Stellar-contract-config-setting.h"

namespace stellar
{

typedef opaque Thresholds[4];
typedef string string32<32>;
typedef string string64<64>;
typedef int64 SequenceNumber;
typedef opaque DataValue<64>;
typedef Hash PoolID; // SHA256(LiquidityPoolParameters)

// 1-4 alphanumeric characters right-padded with 0 bytes
typedef opaque AssetCode4[4];

// 5-12 alphanumeric characters right-padded with 0 bytes
typedef opaque AssetCode12[12];

enum AssetType
{
    ASSET_TYPE_NATIVE = 0,
    ASSET_TYPE_CREDIT_ALPHANUM4 = 1,
    ASSET_TYPE_CREDIT_ALPHANUM12 = 2,
    ASSET_TYPE_POOL_SHARE = 3
};

union AssetCode switch (AssetType type)
{
case ASSET_TYPE_CREDIT_ALPHANUM4:
    AssetCode4 assetCode4;

case ASSET_TYPE_CREDIT_ALPHANUM12:
    AssetCode12 assetCode12;

    // add other asset types here in the future
};

struct AlphaNum4
{
    AssetCode4 assetCode;
    AccountID issuer;
};

struct AlphaNum12
{
    AssetCode12 assetCode;
    AccountID issuer;
};

union Asset switch (AssetType type)
{
case ASSET_TYPE_NATIVE: // Not credit
    void;

case ASSET_TYPE_CREDIT_ALPHANUM4:
    AlphaNum4 alphaNum4;

case ASSET_TYPE_CREDIT_ALPHANUM12:
    AlphaNum12 alphaNum12;

    // add other asset types here in the future
};

// price in fractional representation
struct Price
{
    int32 n; // numerator
    int32 d; // denominator
};

struct Liabilities
{
    int64 buying;
    int64 selling;
};

// the 'Thresholds' type is packed uint8_t values
// defined by these indexes
enum ThresholdIndexes
{
    THRESHOLD_MASTER_WEIGHT = 0,
    THRESHOLD_LOW = 1,
    THRESHOLD_MED = 2,
    THRESHOLD_HIGH = 3
};

enum LedgerEntryType
{
    ACCOUNT = 0,
    TRUSTLINE = 1,
    OFFER = 2,
    DATA = 3,
    CLAIMABLE_BALANCE = 4,
    LIQUIDITY_POOL = 5,
    CONTRACT_DATA = 6,
    CONTRACT_CODE = 7,
    CONFIG_SETTING = 8,
    TTL = 9
};

struct Signer
{
    SignerKey key;
    uint32 weight; // really only need 1 byte
};

enum AccountFlags
{ // masks for each flag

    // Flags set on issuer accounts
    // TrustLines are created with authorized set to "false" requiring
    // the issuer to set it for each TrustLine
    AUTH_REQUIRED_FLAG = 0x1,
    // If set, the authorized flag in TrustLines can be cleared
    // otherwise, authorization cannot be revoked
    AUTH_REVOCABLE_FLAG = 0x2,
    // Once set, causes all AUTH_* flags to be read-only
    AUTH_IMMUTABLE_FLAG = 0x4,
    // Trustlines are created with clawback enabled set to "true",
    // and claimable balances created from those trustlines are created
    // with clawback enabled set to "true"
    AUTH_CLAWBACK_ENABLED_FLAG = 0x8
};

// mask for all valid flags
const MASK_ACCOUNT_FLAGS = 0x7;
const MASK_ACCOUNT_FLAGS_V17 = 0xF;

// maximum number of signers
const MAX_SIGNERS = 20;

typedef AccountID* SponsorshipDescriptor;

struct AccountEntryExtensionV3
{
    // We can use this to add more fields, or because it is first, to
    // change AccountEntryExtensionV3 into a union.
    ExtensionPoint ext;

    // Ledger number at which `seqNum` took on its present value.
    uint32 seqLedger;

    // Time at which `seqNum` took on its present value.
    TimePoint seqTime;
};

struct AccountEntryExtensionV2
{
    uint32 numSponsored;
    uint32 numSponsoring;
    SponsorshipDescriptor signerSponsoringIDs<MAX_SIGNERS>;

    union switch (int v)
    {
    case 0:
        void;
    case 3:
        AccountEntryExtensionV3 v3;
    }
    ext;
};

struct AccountEntryExtensionV1
{
    Liabilities liabilities;

    union switch (int v)
    {
    case 0:
        void;
    case 2:
        AccountEntryExtensionV2 v2;
    }
    ext;
};

/* AccountEntry

    Main entry representing a user in Stellar. All transactions are
    performed using an account.

    Other ledger entries created require an account.

*/
struct AccountEntry
{
    AccountID accountID;      // master public key for this account
    int64 balance;            // in stroops
    SequenceNumber seqNum;    // last sequence number used for this account
    uint32 numSubEntries;     // number of sub-entries this account has
                              // drives the reserve
    AccountID* inflationDest; // Account to vote for during inflation
    uint32 flags;             // see AccountFlags

    string32 homeDomain; // can be used for reverse federation and memo lookup

    // fields used for signatures
    // thresholds stores unsigned bytes: [weight of master|low|medium|high]
    Thresholds thresholds;

    Signer signers<MAX_SIGNERS>; // possible signers for this account

    // reserved for future use
    union switch (int v)
    {
    case 0:
        void;
    case 1:
        AccountEntryExtensionV1 v1;
    }
    ext;
};

/* TrustLineEntry
    A trust line represents a specific trust relationship with
    a credit/issuer (limit, authorization)
    as well as the balance.
*/

enum TrustLineFlags
{
    // issuer has authorized account to perform transactions with its credit
    AUTHORIZED_FLAG = 1,
    // issuer has authorized account to maintain and reduce liabilities for its
    // credit
    AUTHORIZED_TO_MAINTAIN_LIABILITIES_FLAG = 2,
    // issuer has specified that it may clawback its credit, and that claimable
    // balances created with its credit may also be clawed back
    TRUSTLINE_CLAWBACK_ENABLED_FLAG = 4
};

// mask for all trustline flags
const MASK_TRUSTLINE_FLAGS = 1;
const MASK_TRUSTLINE_FLAGS_V13 = 3;
const MASK_TRUSTLINE_FLAGS_V17 = 7;

enum LiquidityPoolType
{
    LIQUIDITY_POOL_CONSTANT_PRODUCT = 0
};

union TrustLineAsset switch (AssetType type)
{
case ASSET_TYPE_NATIVE: // Not credit
    void;

case ASSET_TYPE_CREDIT_ALPHANUM4:
    AlphaNum4 alphaNum4;

case ASSET_TYPE_CREDIT_ALPHANUM12:
    AlphaNum12 alphaNum12;

case ASSET_TYPE_POOL_SHARE:
    PoolID liquidityPoolID;

    // add other asset types here in the future
};

struct TrustLineEntryExtensionV2
{
    int32 liquidityPoolUseCount;

    union switch (int v)
    {
    case 0:
        void;
    }
    ext;
};

struct TrustLineEntry
{
    AccountID accountID;  // account this trustline belongs to
    TrustLineAsset asset; // type of asset (with issuer)
    int64 balance;        // how much of this asset the user has.
                          // Asset defines the unit for this;

    int64 limit;  // balance cannot be above this
    uint32 flags; // see TrustLineFlags

    // reserved for future use
    union switch (int v)
    {
    case 0:
        void;
    case 1:
        struct
        {
            Liabilities liabilities;

            union switch (int v)
            {
            case 0:
                void;
            case 2:
                TrustLineEntryExtensionV2 v2;
            }
            ext;
        } v1;
    }
    ext;
};

enum OfferEntryFlags
{
    // an offer with this flag will not act on and take a reverse offer of equal
    // price
    PASSIVE_FLAG = 1
};

// Mask for OfferEntry flags
const MASK_OFFERENTRY_FLAGS = 1;

/* OfferEntry
    An offer is the building block of the offer book, they are automatically
    claimed by payments when the price set by the owner is met.

    For example an Offer is selling 10A where 1A is priced at 1.5B

*/
struct OfferEntry
{
    AccountID sellerID;
    int64 offerID;
    Asset selling; // A
    Asset buying;  // B
    int64 amount;  // amount of A

    /* price for this offer:
        price of A in terms of B
        price=AmountB/AmountA=priceNumerator/priceDenominator
        price is after fees
    */
    Price price;
    uint32 flags; // see OfferEntryFlags

    // reserved for future use
    union switch (int v)
    {
    case 0:
        void;
    }
    ext;
};

/* DataEntry
    Data can be attached to accounts.
*/
struct DataEntry
{
    AccountID accountID; // account this data belongs to
    string64 dataName;
    DataValue dataValue;

    // reserved for future use
    union switch (int v)
    {
    case 0:
        void;
    }
    ext;
};

enum ClaimPredicateType
{
    CLAIM_PREDICATE_UNCONDITIONAL = 0,
    CLAIM_PREDICATE_AND = 1,
    CLAIM_PREDICATE_OR = 2,
    CLAIM_PREDICATE_NOT = 3,
    CLAIM_PREDICATE_BEFORE_ABSOLUTE_TIME = 4,
    CLAIM_PREDICATE_BEFORE_RELATIVE_TIME = 5
};

union ClaimPredicate switch (ClaimPredicateType type)
{
case CLAIM_PREDICATE_UNCONDITIONAL:
    void;
case CLAIM_PREDICATE_AND:
    ClaimPredicate andPredicates<2>;
case CLAIM_PREDICATE_OR:
    ClaimPredicate orPredicates<2>;
case CLAIM_PREDICATE_NOT:
    ClaimPredicate* notPredicate;
case CLAIM_PREDICATE_BEFORE_ABSOLUTE_TIME:
    int64 absBefore; // Predicate will be true if closeTime < absBefore
case CLAIM_PREDICATE_BEFORE_RELATIVE_TIME:
    int64 relBefore; // Seconds since closeTime of the ledger in which the
                     // ClaimableBalanceEntry was created
};

enum ClaimantType
{
    CLAIMANT_TYPE_V0 = 0
};

union Claimant switch (ClaimantType type)
{
case CLAIMANT_TYPE_V0:
    struct
    {
        AccountID destination;    // The account that can use this condition
        ClaimPredicate predicate; // Claimable if predicate is true
    } v0;
};

enum ClaimableBalanceIDType
{
    CLAIMABLE_BALANCE_ID_TYPE_V0 = 0
};

union ClaimableBalanceID switch (ClaimableBalanceIDType type)
{
case CLAIMABLE_BALANCE_ID_TYPE_V0:
    Hash v0;
};

enum ClaimableBalanceFlags
{
    // If set, the issuer account of the asset held by the claimable balance may
    // clawback the claimable balance
    CLAIMABLE_BALANCE_CLAWBACK_ENABLED_FLAG = 0x1
};

const MASK_CLAIMABLE_BALANCE_FLAGS = 0x1;

struct ClaimableBalanceEntryExtensionV1
{
    union switch (int v)
    {
    case 0:
        void;
    }
    ext;

    uint32 flags; // see ClaimableBalanceFlags
};

struct ClaimableBalanceEntry
{
    // Unique identifier for this ClaimableBalanceEntry
    ClaimableBalanceID balanceID;

    // List of claimants with associated predicate
    Claimant claimants<10>;

    // Any asset including native
    Asset asset;

    // Amount of asset
    int64 amount;

    // reserved for future use
    union switch (int v)
    {
    case 0:
        void;
    case 1:
        ClaimableBalanceEntryExtensionV1 v1;
    }
    ext;
};

struct LiquidityPoolConstantProductParameters
{
    Asset assetA; // assetA < assetB
    Asset assetB;
    int32 fee; // Fee is in basis points, so the actual rate is (fee/100)%
};

struct LiquidityPoolEntry
{
    PoolID liquidityPoolID;

    union switch (LiquidityPoolType type)
    {
    case LIQUIDITY_POOL_CONSTANT_PRODUCT:
        struct
        {
            LiquidityPoolConstantProductParameters params;

            int64 reserveA;        // amount of A in the pool
            int64 reserveB;        // amount of B in the pool
            int64 totalPoolShares; // total number of pool shares issued
            int64 poolSharesTrustLineCount; // number of trust lines for the
                                            // associated pool shares
        } constantProduct;
    }
    body;
};

enum ContractDataDurability {
    TEMPORARY = 0,
    PERSISTENT = 1
};

struct ContractDataEntry {
    ExtensionPoint ext;

    SCAddress contract;
    SCVal key;
    ContractDataDurability durability;
    SCVal val;
};

struct ContractCodeEntry {
    ExtensionPoint ext;

    Hash hash;
    opaque code<>;
};

struct TTLEntry {
    // Hash of the LedgerKey that is associated with this TTLEntry
    Hash keyHash;
    uint32 liveUntilLedgerSeq;
};

struct LedgerEntryExtensionV1
{
    SponsorshipDescriptor sponsoringID;

    union switch (int v)
    {
    case 0:
        void;
    }
    ext;
};

struct LedgerEntry
{
    uint32 lastModifiedLedgerSeq; // ledger the LedgerEntry was last changed

    union switch (LedgerEntryType type)
    {
    case ACCOUNT:
        AccountEntry account;
    case TRUSTLINE:
        TrustLineEntry trustLine;
    case OFFER:
        OfferEntry offer;
    case DATA:
        DataEntry data;
    case CLAIMABLE_BALANCE:
        ClaimableBalanceEntry claimableBalance;
    case LIQUIDITY_POOL:
        LiquidityPoolEntry liquidityPool;
    case CONTRACT_DATA:
        ContractDataEntry contractData;
    case CONTRACT_CODE:
        ContractCodeEntry contractCode;
    case CONFIG_SETTING:
        ConfigSettingEntry configSetting;
    case TTL:
        TTLEntry ttl;
    }
    data;

    // reserved for future use
    union switch (int v)
    {
    case 0:
        void;
    case 1:
        LedgerEntryExtensionV1 v1;
    }
    ext;
};

union LedgerKey switch (LedgerEntryType type)
{
case ACCOUNT:
    struct
    {
        AccountID accountID;
    } account;

case TRUSTLINE:
    struct
    {
        AccountID accountID;
        TrustLineAsset asset;
    } trustLine;

case OFFER:
    struct
    {
        AccountID sellerID;
        int64 offerID;
    } offer;

case DATA:
    struct
    {
        AccountID accountID;
        string64 dataName;
    } data;

case CLAIMABLE_BALANCE:
    struct
    {
        ClaimableBalanceID balanceID;
    } claimableBalance;

case LIQUIDITY_POOL:
    struct
    {
        PoolID liquidityPoolID;
    } liquidityPool;
case CONTRACT_DATA:
    struct
    {
        SCAddress contract;
        SCVal key;
        ContractDataDurability durability;
    } contractData;
case CONTRACT_CODE:
    struct
    {
        Hash hash;
    } contractCode;
case CONFIG_SETTING:
    struct
    {
        ConfigSettingID configSettingID;
    } configSetting;
case TTL:
    struct
    {
        // Hash of the LedgerKey that is associated with this TTLEntry
        Hash keyHash;
    } ttl;
};

// list of all envelope types used in the application
// those are prefixes used when building signatures for
// the respective envelopes
enum EnvelopeType
{
    ENVELOPE_TYPE_TX_V0 = 0,
    ENVELOPE_TYPE_SCP = 1,
    ENVELOPE_TYPE_TX = 2,
    ENVELOPE_TYPE_AUTH = 3,
    ENVELOPE_TYPE_SCPVALUE = 4,
    ENVELOPE_TYPE_TX_FEE_BUMP = 5,
    ENVELOPE_TYPE_OP_ID = 6,
    ENVELOPE_TYPE_POOL_REVOKE_OP_ID = 7,
    ENVELOPE_TYPE_CONTRACT_ID = 8,
    ENVELOPE_TYPE_SOROBAN_AUTHORIZATION = 9
};
}

// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-contract.h"
%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

// maximum number of operations per transaction
const MAX_OPS_PER_TX = 100;

union LiquidityPoolParameters switch (LiquidityPoolType type)
{
case LIQUIDITY_POOL_CONSTANT_PRODUCT:
    LiquidityPoolConstantProductParameters constantProduct;
};

// Source or destination of a payment operation
union MuxedAccount switch (CryptoKeyType type)
{
case KEY_TYPE_ED25519:
    uint256 ed25519;
case KEY_TYPE_MUXED_ED25519:
    struct
    {
        uint64 id;
        uint256 ed25519;
    } med25519;
};

struct DecoratedSignature
{
    SignatureHint hint;  // last 4 bytes of the public key, used as a hint
    Signature signature; // actual signature
};

enum OperationType
{
    CREATE_ACCOUNT = 0,
    PAYMENT = 1,
    PATH_PAYMENT_STRICT_RECEIVE = 2,
    MANAGE_SELL_OFFER = 3,
    CREATE_PASSIVE_SELL_OFFER = 4,
    SET_OPTIONS = 5,
    CHANGE_TRUST = 6,
    ALLOW_TRUST = 7,
    ACCOUNT_MERGE = 8,
    INFLATION = 9,
    MANAGE_DATA = 10,
    BUMP_SEQUENCE = 11,
    MANAGE_BUY_OFFER = 12,
    PATH_PAYMENT_STRICT_SEND = 13,
    CREATE_CLAIMABLE_BALANCE = 14,
    CLAIM_CLAIMABLE_BALANCE = 15,
    BEGIN_SPONSORING_FUTURE_RESERVES = 16,
    END_SPONSORING_FUTURE_RESERVES = 17,
    REVOKE_SPONSORSHIP = 18,
    CLAWBACK = 19,
    CLAWBACK_CLAIMABLE_BALANCE = 20,
    SET_TRUST_LINE_FLAGS = 21,
    LIQUIDITY_POOL_DEPOSIT = 22,
    LIQUIDITY_POOL_WITHDRAW = 23,
    INVOKE_HOST_FUNCTION = 24,
    EXTEND_FOOTPRINT_TTL = 25,
    RESTORE_FOOTPRINT = 26
};

/* CreateAccount
Creates and funds a new account with the specified starting balance.

Threshold: med

Result: CreateAccountResult

*/
struct CreateAccountOp
{
    AccountID destination; // account to create
    int64 startingBalance; // amount they end up with
};

/* Payment

    Send an amount in specified asset to a destination account.

    Threshold: med

    Result: PaymentResult
*/
struct PaymentOp
{
    MuxedAccount destination; // recipient of the payment
    Asset asset;              // what they end up with
    int64 amount;             // amount they end up with
};

/* PathPaymentStrictReceive

send an amount to a destination account through a path.
(up to sendMax, sendAsset)
(X0, Path[0]) .. (Xn, Path[n])
(destAmount, destAsset)

Threshold: med

Result: PathPaymentStrictReceiveResult
*/
struct PathPaymentStrictReceiveOp
{
    Asset sendAsset; // asset we pay with
    int64 sendMax;   // the maximum amount of sendAsset to
                     // send (excluding fees).
                     // The operation will fail if can't be met

    MuxedAccount destination; // recipient of the payment
    Asset destAsset;          // what they end up with
    int64 destAmount;         // amount they end up with

    Asset path<5>; // additional hops it must go through to get there
};

/* PathPaymentStrictSend

send an amount to a destination account through a path.
(sendMax, sendAsset)
(X0, Path[0]) .. (Xn, Path[n])
(at least destAmount, destAsset)

Threshold: med

Result: PathPaymentStrictSendResult
*/
struct PathPaymentStrictSendOp
{
    Asset sendAsset;  // asset we pay with
    int64 sendAmount; // amount of sendAsset to send (excluding fees)

    MuxedAccount destination; // recipient of the payment
    Asset destAsset;          // what they end up with
    int64 destMin;            // the minimum amount of dest asset to
                              // be received
                              // The operation will fail if it can't be met

    Asset path<5>; // additional hops it must go through to get there
};

/* Creates, updates or deletes an offer

Threshold: med

Result: ManageSellOfferResult

*/
struct ManageSellOfferOp
{
    Asset selling;
    Asset buying;
    int64 amount; // amount being sold. if set to 0, delete the offer
    Price price;  // price of thing being sold in terms of what you are buying

    // 0=create a new offer, otherwise edit an existing offer
    int64 offerID;
};

/* Creates, updates or deletes an offer with amount in terms of buying asset

Threshold: med

Result: ManageBuyOfferResult

*/
struct ManageBuyOfferOp
{
    Asset selling;
    Asset buying;
    int64 buyAmount; // amount being bought. if set to 0, delete the offer
    Price price;     // price of thing being bought in terms of what you are
                     // selling

    // 0=create a new offer, otherwise edit an existing offer
    int64 offerID;
};

/* Creates an offer that doesn't take offers of the same price

Threshold: med

Result: CreatePassiveSellOfferResult

*/
struct CreatePassiveSellOfferOp
{
    Asset selling; // A
    Asset buying;  // B
    int64 amount;  // amount taker gets
    Price price;   // cost of A in terms of B
};

/* Set Account Options

    updates "AccountEntry" fields.
    note: updating thresholds or signers requires high threshold

    Threshold: med or high

    Result: SetOptionsResult
*/
struct SetOptionsOp
{
    AccountID* inflationDest; // sets the inflation destination

    uint32* clearFlags; // which flags to clear
    uint32* setFlags;   // which flags to set

    // account threshold manipulation
    uint32* masterWeight; // weight of the master account
    uint32* lowThreshold;
    uint32* medThreshold;
    uint32* highThreshold;

    string32* homeDomain; // sets the home domain

    // Add, update or remove a signer for the account
    // signer is deleted if the weight is 0
    Signer* signer;
};

union ChangeTrustAsset switch (AssetType type)
{
case ASSET_TYPE_NATIVE: // Not credit
    void;

case ASSET_TYPE_CREDIT_ALPHANUM4:
    AlphaNum4 alphaNum4;

case ASSET_TYPE_CREDIT_ALPHANUM12:
    AlphaNum12 alphaNum12;

case ASSET_TYPE_POOL_SHARE:
    LiquidityPoolParameters liquidityPool;

    // add other asset types here in the future
};

/* Creates, updates or deletes a trust line

    Threshold: med

    Result: ChangeTrustResult

*/
struct ChangeTrustOp
{
    ChangeTrustAsset line;

    // if limit is set to 0, deletes the trust line
    int64 limit;
};

/* Updates the "authorized" flag of an existing trust line
   this is called by the issuer of the related asset.

   note that authorize can only be set (and not cleared) if
   the issuer account does not have the AUTH_REVOCABLE_FLAG set
   Threshold: low

   Result: AllowTrustResult
*/
struct AllowTrustOp
{
    AccountID trustor;
    AssetCode asset;

    // One of 0, AUTHORIZED_FLAG, or AUTHORIZED_TO_MAINTAIN_LIABILITIES_FLAG
    uint32 authorize;
};

/* Inflation
    Runs inflation

Threshold: low

Result: InflationResult

*/

/* AccountMerge
    Transfers native balance to destination account.

    Threshold: high

    Result : AccountMergeResult
*/

/* ManageData
    Adds, Updates, or Deletes a key value pair associated with a particular
        account.

    Threshold: med

    Result: ManageDataResult
*/
struct ManageDataOp
{
    string64 dataName;
    DataValue* dataValue; // set to null to clear
};

/* Bump Sequence

    increases the sequence to a given level

    Threshold: low

    Result: BumpSequenceResult
*/
struct BumpSequenceOp
{
    SequenceNumber bumpTo;
};

/* Creates a claimable balance entry

    Threshold: med

    Result: CreateClaimableBalanceResult
*/
struct CreateClaimableBalanceOp
{
    Asset asset;
    int64 amount;
    Claimant claimants<10>;
};

/* Claims a claimable balance entry

    Threshold: low

    Result: ClaimClaimableBalanceResult
*/
struct ClaimClaimableBalanceOp
{
    ClaimableBalanceID balanceID;
};

/* BeginSponsoringFutureReserves

    Establishes the is-sponsoring-future-reserves-for relationship between
    the source account and sponsoredID

    Threshold: med

    Result: BeginSponsoringFutureReservesResult
*/
struct BeginSponsoringFutureReservesOp
{
    AccountID sponsoredID;
};

/* EndSponsoringFutureReserves

    Terminates the current is-sponsoring-future-reserves-for relationship in
    which source account is sponsored

    Threshold: med

    Result: EndSponsoringFutureReservesResult
*/
// EndSponsoringFutureReserves is empty

/* RevokeSponsorship

    If source account is not sponsored or is sponsored by the owner of the
    specified entry or sub-entry, then attempt to revoke the sponsorship.
    If source account is sponsored, then attempt to transfer the sponsorship
    to the sponsor of source account.

    Threshold: med

    Result: RevokeSponsorshipResult
*/
enum RevokeSponsorshipType
{
    REVOKE_SPONSORSHIP_LEDGER_ENTRY = 0,
    REVOKE_SPONSORSHIP_SIGNER = 1
};

union RevokeSponsorshipOp switch (RevokeSponsorshipType type)
{
case REVOKE_SPONSORSHIP_LEDGER_ENTRY:
    LedgerKey ledgerKey;
case REVOKE_SPONSORSHIP_SIGNER:
    struct
    {
        AccountID accountID;
        SignerKey signerKey;
    } signer;
};

/* Claws back an amount of an asset from an account

    Threshold: med

    Result: ClawbackResult
*/
struct ClawbackOp
{
    Asset asset;
    MuxedAccount from;
    int64 amount;
};

/* Claws back a claimable balance

    Threshold: med

    Result: ClawbackClaimableBalanceResult
*/
struct ClawbackClaimableBalanceOp
{
    ClaimableBalanceID balanceID;
};

/* SetTrustLineFlagsOp

   Updates the flags of an existing trust line.
   This is called by the issuer of the related asset.

   Threshold: low

   Result: SetTrustLineFlagsResult
*/
struct SetTrustLineFlagsOp
{
    AccountID trustor;
    Asset asset;

    uint32 clearFlags; // which flags to clear
    uint32 setFlags;   // which flags to set
};

const LIQUIDITY_POOL_FEE_V18 = 30;

/* Deposit assets into a liquidity pool

    Threshold: med

    Result: LiquidityPoolDepositResult
*/
struct LiquidityPoolDepositOp
{
    PoolID liquidityPoolID;
    int64 maxAmountA; // maximum amount of first asset to deposit
    int64 maxAmountB; // maximum amount of second asset to deposit
    Price minPrice;   // minimum depositA/depositB
    Price maxPrice;   // maximum depositA/depositB
};

/* Withdraw assets from a liquidity pool

    Threshold: med

    Result: LiquidityPoolWithdrawResult
*/
struct LiquidityPoolWithdrawOp
{
    PoolID liquidityPoolID;
    int64 amount;     // amount of pool shares to withdraw
    int64 minAmountA; // minimum amount of first asset to withdraw
    int64 minAmountB; // minimum amount of second asset to withdraw
};

enum HostFunctionType
{
    HOST_FUNCTION_TYPE_INVOKE_CONTRACT = 0,
    HOST_FUNCTION_TYPE_CREATE_CONTRACT = 1,
    HOST_FUNCTION_TYPE_UPLOAD_CONTRACT_WASM = 2
};

enum ContractIDPreimageType
{
    CONTRACT_ID_PREIMAGE_FROM_ADDRESS = 0,
    CONTRACT_ID_PREIMAGE_FROM_ASSET = 1
};
 
union ContractIDPreimage switch (ContractIDPreimageType type)
{
case CONTRACT_ID_PREIMAGE_FROM_ADDRESS:
    struct
    {
        SCAddress address;
        uint256 salt;
    } fromAddress;
case CONTRACT_ID_PREIMAGE_FROM_ASSET:
    Asset fromAsset;
};

struct CreateContractArgs
{
    ContractIDPreimage contractIDPreimage;
    ContractExecutable executable;
};

struct InvokeContractArgs {
    SCAddress contractAddress;
    SCSymbol functionName;
    SCVal args<>;
};

union HostFunction switch (HostFunctionType type)
{
case HOST_FUNCTION_TYPE_INVOKE_CONTRACT:
    InvokeContractArgs invokeContract;
case HOST_FUNCTION_TYPE_CREATE_CONTRACT:
    CreateContractArgs createContract;
case HOST_FUNCTION_TYPE_UPLOAD_CONTRACT_WASM:
    opaque wasm<>;
};

enum SorobanAuthorizedFunctionType
{
    SOROBAN_AUTHORIZED_FUNCTION_TYPE_CONTRACT_FN = 0,
    SOROBAN_AUTHORIZED_FUNCTION_TYPE_CREATE_CONTRACT_HOST_FN = 1
};

union SorobanAuthorizedFunction switch (SorobanAuthorizedFunctionType type)
{
case SOROBAN_AUTHORIZED_FUNCTION_TYPE_CONTRACT_FN:
    InvokeContractArgs contractFn;
case SOROBAN_AUTHORIZED_FUNCTION_TYPE_CREATE_CONTRACT_HOST_FN:
    CreateContractArgs createContractHostFn;
};

struct SorobanAuthorizedInvocation
{
    SorobanAuthorizedFunction function;
    SorobanAuthorizedInvocation subInvocations<>;
};

struct SorobanAddressCredentials
{
    SCAddress address;
    int64 nonce;
    uint32 signatureExpirationLedger;    
    SCVal signature;
};

enum SorobanCredentialsType
{
    SOROBAN_CREDENTIALS_SOURCE_ACCOUNT = 0,
    SOROBAN_CREDENTIALS_ADDRESS = 1
};

union SorobanCredentials switch (SorobanCredentialsType type)
{
case SOROBAN_CREDENTIALS_SOURCE_ACCOUNT:
    void;
case SOROBAN_CREDENTIALS_ADDRESS:
    SorobanAddressCredentials address;
};

/* Unit of authorization data for Soroban.

   Represents an authorization for executing the tree of authorized contract 
   and/or host function calls by the user defined by `credentials`.
*/
struct SorobanAuthorizationEntry
{
    SorobanCredentials credentials;
    SorobanAuthorizedInvocation rootInvocation;
};

/* Upload WASM, create, and invoke contracts in Soroban.

    Threshold: med
    Result: InvokeHostFunctionResult
*/
struct InvokeHostFunctionOp
{
    // Host function to invoke.
    HostFunction hostFunction;
    // Per-address authorizations for this host function.
    SorobanAuthorizationEntry auth<>;
};

/* Extend the TTL of the entries specified in the readOnly footprint
   so they will live at least extendTo ledgers from lcl.

    Threshold: med
    Result: ExtendFootprintTTLResult
*/
struct ExtendFootprintTTLOp
{
    ExtensionPoint ext;
    uint32 extendTo;
};

/* Restore the archived entries specified in the readWrite footprint.

    Threshold: med
    Result: RestoreFootprintOp
*/
struct RestoreFootprintOp
{
    ExtensionPoint ext;
};

/* An operation is the lowest unit of work that a transaction does */
struct Operation
{
    // sourceAccount is the account used to run the operation
    // if not set, the runtime defaults to "sourceAccount" specified at
    // the transaction level
    MuxedAccount* sourceAccount;

    union switch (OperationType type)
    {
    case CREATE_ACCOUNT:
        CreateAccountOp createAccountOp;
    case PAYMENT:
        PaymentOp paymentOp;
    case PATH_PAYMENT_STRICT_RECEIVE:
        PathPaymentStrictReceiveOp pathPaymentStrictReceiveOp;
    case MANAGE_SELL_OFFER:
        ManageSellOfferOp manageSellOfferOp;
    case CREATE_PASSIVE_SELL_OFFER:
        CreatePassiveSellOfferOp createPassiveSellOfferOp;
    case SET_OPTIONS:
        SetOptionsOp setOptionsOp;
    case CHANGE_TRUST:
        ChangeTrustOp changeTrustOp;
    case ALLOW_TRUST:
        AllowTrustOp allowTrustOp;
    case ACCOUNT_MERGE:
        MuxedAccount destination;
    case INFLATION:
        void;
    case MANAGE_DATA:
        ManageDataOp manageDataOp;
    case BUMP_SEQUENCE:
        BumpSequenceOp bumpSequenceOp;
    case MANAGE_BUY_OFFER:
        ManageBuyOfferOp manageBuyOfferOp;
    case PATH_PAYMENT_STRICT_SEND:
        PathPaymentStrictSendOp pathPaymentStrictSendOp;
    case CREATE_CLAIMABLE_BALANCE:
        CreateClaimableBalanceOp createClaimableBalanceOp;
    case CLAIM_CLAIMABLE_BALANCE:
        ClaimClaimableBalanceOp claimClaimableBalanceOp;
    case BEGIN_SPONSORING_FUTURE_RESERVES:
        BeginSponsoringFutureReservesOp beginSponsoringFutureReservesOp;
    case END_SPONSORING_FUTURE_RESERVES:
        void;
    case REVOKE_SPONSORSHIP:
        RevokeSponsorshipOp revokeSponsorshipOp;
    case CLAWBACK:
        ClawbackOp clawbackOp;
    case CLAWBACK_CLAIMABLE_BALANCE:
        ClawbackClaimableBalanceOp clawbackClaimableBalanceOp;
    case SET_TRUST_LINE_FLAGS:
        SetTrustLineFlagsOp setTrustLineFlagsOp;
    case LIQUIDITY_POOL_DEPOSIT:
        LiquidityPoolDepositOp liquidityPoolDepositOp;
    case LIQUIDITY_POOL_WITHDRAW:
        LiquidityPoolWithdrawOp liquidityPoolWithdrawOp;
    case INVOKE_HOST_FUNCTION:
        InvokeHostFunctionOp invokeHostFunctionOp;
    case EXTEND_FOOTPRINT_TTL:
        ExtendFootprintTTLOp extendFootprintTTLOp;
    case RESTORE_FOOTPRINT:
        RestoreFootprintOp restoreFootprintOp;
    }
    body;
};

union HashIDPreimage switch (EnvelopeType type)
{
case ENVELOPE_TYPE_OP_ID:
    struct
    {
        AccountID sourceAccount;
        SequenceNumber seqNum;
        uint32 opNum;
    } operationID;
case ENVELOPE_TYPE_POOL_REVOKE_OP_ID:
    struct
    {
        AccountID sourceAccount;
        SequenceNumber seqNum; 
        uint32 opNum;
        PoolID liquidityPoolID;
        Asset asset;
    } revokeID;
case ENVELOPE_TYPE_CONTRACT_ID:
    struct
    {
        Hash networkID;
        ContractIDPreimage contractIDPreimage;
    } contractID;
case ENVELOPE_TYPE_SOROBAN_AUTHORIZATION:
    struct
    {
        Hash networkID;
        int64 nonce;
        uint32 signatureExpirationLedger;
        SorobanAuthorizedInvocation invocation;
    } sorobanAuthorization;
};

enum MemoType
{
    MEMO_NONE = 0,
    MEMO_TEXT = 1,
    MEMO_ID = 2,
    MEMO_HASH = 3,
    MEMO_RETURN = 4
};

union Memo switch (MemoType type)
{
case MEMO_NONE:
    void;
case MEMO_TEXT:
    string text<28>;
case MEMO_ID:
    uint64 id;
case MEMO_HASH:
    Hash hash; // the hash of what to pull from the content server
case MEMO_RETURN:
    Hash retHash; // the hash of the tx you are rejecting
};

struct TimeBounds
{
    TimePoint minTime;
    TimePoint maxTime; // 0 here means no maxTime
};

struct LedgerBounds
{
    uint32 minLedger;
    uint32 maxLedger; // 0 here means no maxLedger
};

struct PreconditionsV2
{
    TimeBounds* timeBounds;

    // Transaction only valid for ledger numbers n such that
    // minLedger <= n < maxLedger (if maxLedger == 0, then
    // only minLedger is checked)
    LedgerBounds* ledgerBounds;

    // If NULL, only valid when sourceAccount's sequence number
    // is seqNum - 1.  Otherwise, valid when sourceAccount's
    // sequence number n satisfies minSeqNum <= n < tx.seqNum.
    // Note that after execution the account's sequence number
    // is always raised to tx.seqNum, and a transaction is not
    // valid if tx.seqNum is too high to ensure replay protection.
    SequenceNumber* minSeqNum;

    // For the transaction to be valid, the current ledger time must
    // be at least minSeqAge greater than sourceAccount's seqTime.
    Duration minSeqAge;

    // For the transaction to be valid, the current ledger number
    // must be at least minSeqLedgerGap greater than sourceAccount's
    // seqLedger.
    uint32 minSeqLedgerGap;

    // For the transaction to be valid, there must be a signature
    // corresponding to every Signer in this array, even if the
    // signature is not otherwise required by the sourceAccount or
    // operations.
    SignerKey extraSigners<2>;
};

enum PreconditionType
{
    PRECOND_NONE = 0,
    PRECOND_TIME = 1,
    PRECOND_V2 = 2
};

union Preconditions switch (PreconditionType type)
{
case PRECOND_NONE:
    void;
case PRECOND_TIME:
    TimeBounds timeBounds;
case PRECOND_V2:
    PreconditionsV2 v2;
};

// Ledger key sets touched by a smart contract transaction.
struct LedgerFootprint
{
    LedgerKey readOnly<>;
    LedgerKey readWrite<>;
};

// Resource limits for a Soroban transaction.
// The transaction will fail if it exceeds any of these limits.
struct SorobanResources
{   
    // The ledger footprint of the transaction.
    LedgerFootprint footprint;
    // The maximum number of instructions this transaction can use
    uint32 instructions; 

    // The maximum number of bytes this transaction can read from ledger
    uint32 readBytes;
    // The maximum number of bytes this transaction can write to ledger
    uint32 writeBytes;
};

// The transaction extension for Soroban.
struct SorobanTransactionData
{
    ExtensionPoint ext;
    SorobanResources resources;
    // Amount of the transaction `fee` allocated to the Soroban resource fees.
    // The fraction of `resourceFee` corresponding to `resources` specified 
    // above is *not* refundable (i.e. fees for instructions, ledger I/O), as
    // well as fees for the transaction size.
    // The remaining part of the fee is refundable and the charged value is
    // based on the actual consumption of refundable resources (events, ledger
    // rent bumps).
    // The `inclusionFee` used for prioritization of the transaction is defined
    // as `tx.fee - resourceFee`.
    int64 resourceFee;
};

// TransactionV0 is a transaction with the AccountID discriminant stripped off,
// leaving a raw ed25519 public key to identify the source account. This is used
// for backwards compatibility starting from the protocol 12/13 boundary. If an
// "old-style" TransactionEnvelope containing a Transaction is parsed with this
// XDR definition, it will be parsed as a "new-style" TransactionEnvelope
// containing a TransactionV0.
struct TransactionV0
{
    uint256 sourceAccountEd25519;
    uint32 fee;
    SequenceNumber seqNum;
    TimeBounds* timeBounds;
    Memo memo;
    Operation operations<MAX_OPS_PER_TX>;
    union switch (int v)
    {
    case 0:
        void;
    }
    ext;
};

struct TransactionV0Envelope
{
    TransactionV0 tx;
    /* Each decorated signature is a signature over the SHA256 hash of
     * a TransactionSignaturePayload */
    DecoratedSignature signatures<20>;
};

/* a transaction is a container for a set of operations
    - is executed by an account
    - fees are collected from the account
    - operations are executed in order as one ACID transaction
          either all operations are applied or none are
          if any returns a failing code
*/
struct Transaction
{
    // account used to run the transaction
    MuxedAccount sourceAccount;

    // the fee the sourceAccount will pay
    uint32 fee;

    // sequence number to consume in the account
    SequenceNumber seqNum;

    // validity conditions
    Preconditions cond;

    Memo memo;

    Operation operations<MAX_OPS_PER_TX>;

    // reserved for future use
    union switch (int v)
    {
    case 0:
        void;
    case 1:
        SorobanTransactionData sorobanData;
    }
    ext;
};

struct TransactionV1Envelope
{
    Transaction tx;
    /* Each decorated signature is a signature over the SHA256 hash of
     * a TransactionSignaturePayload */
    DecoratedSignature signatures<20>;
};

struct FeeBumpTransaction
{
    MuxedAccount feeSource;
    int64 fee;
    union switch (EnvelopeType type)
    {
    case ENVELOPE_TYPE_TX:
        TransactionV1Envelope v1;
    }
    innerTx;
    union switch (int v)
    {
    case 0:
        void;
    }
    ext;
};

struct FeeBumpTransactionEnvelope
{
    FeeBumpTransaction tx;
    /* Each decorated signature is a signature over the SHA256 hash of
     * a TransactionSignaturePayload */
    DecoratedSignature signatures<20>;
};

/* A TransactionEnvelope wraps a transaction with signatures. */
union TransactionEnvelope switch (EnvelopeType type)
{
case ENVELOPE_TYPE_TX_V0:
    TransactionV0Envelope v0;
case ENVELOPE_TYPE_TX:
    TransactionV1Envelope v1;
case ENVELOPE_TYPE_TX_FEE_BUMP:
    FeeBumpTransactionEnvelope feeBump;
};

struct TransactionSignaturePayload
{
    Hash networkId;
    union switch (EnvelopeType type)
    {
    // Backwards Compatibility: Use ENVELOPE_TYPE_TX to sign ENVELOPE_TYPE_TX_V0
    case ENVELOPE_TYPE_TX:
        Transaction tx;
    case ENVELOPE_TYPE_TX_FEE_BUMP:
        FeeBumpTransaction feeBump;
    }
    taggedTransaction;
};

/* Operation Results section */

enum ClaimAtomType
{
    CLAIM_ATOM_TYPE_V0 = 0,
    CLAIM_ATOM_TYPE_ORDER_BOOK = 1,
    CLAIM_ATOM_TYPE_LIQUIDITY_POOL = 2
};

// ClaimOfferAtomV0 is a ClaimOfferAtom with the AccountID discriminant stripped
// off, leaving a raw ed25519 public key to identify the source account. This is
// used for backwards compatibility starting from the protocol 17/18 boundary.
// If an "old-style" ClaimOfferAtom is parsed with this XDR definition, it will
// be parsed as a "new-style" ClaimAtom containing a ClaimOfferAtomV0.
struct ClaimOfferAtomV0
{
    // emitted to identify the offer
    uint256 sellerEd25519; // Account that owns the offer
    int64 offerID;

    // amount and asset taken from the owner
    Asset assetSold;
    int64 amountSold;

    // amount and asset sent to the owner
    Asset assetBought;
    int64 amountBought;
};

struct ClaimOfferAtom
{
    // emitted to identify the offer
    AccountID sellerID; // Account that owns the offer
    int64 offerID;

    // amount and asset taken from the owner
    Asset assetSold;
    int64 amountSold;

    // amount and asset sent to the owner
    Asset assetBought;
    int64 amountBought;
};

struct ClaimLiquidityAtom
{
    PoolID liquidityPoolID;

    // amount and asset taken from the pool
    Asset assetSold;
    int64 amountSold;

    // amount and asset sent to the pool
    Asset assetBought;
    int64 amountBought;
};

/* This result is used when offers are taken or liquidity is exchanged with a
   liquidity pool during an operation
*/
union ClaimAtom switch (ClaimAtomType type)
{
case CLAIM_ATOM_TYPE_V0:
    ClaimOfferAtomV0 v0;
case CLAIM_ATOM_TYPE_ORDER_BOOK:
    ClaimOfferAtom orderBook;
case CLAIM_ATOM_TYPE_LIQUIDITY_POOL:
    ClaimLiquidityAtom liquidityPool;
};

/******* CreateAccount Result ********/

enum CreateAccountResultCode
{
    // codes considered as "success" for the operation
    CREATE_ACCOUNT_SUCCESS = 0, // account was created

    // codes considered as "failure" for the operation
    CREATE_ACCOUNT_MALFORMED = -1,   // invalid destination
    CREATE_ACCOUNT_UNDERFUNDED = -2, // not enough funds in source account
    CREATE_ACCOUNT_LOW_RESERVE =
        -3, // would create an account below the min reserve
    CREATE_ACCOUNT_ALREADY_EXIST = -4 // account already exists
};

union CreateAccountResult switch (CreateAccountResultCode code)
{
case CREATE_ACCOUNT_SUCCESS:
    void;
case CREATE_ACCOUNT_MALFORMED:
case CREATE_ACCOUNT_UNDERFUNDED:
case CREATE_ACCOUNT_LOW_RESERVE:
case CREATE_ACCOUNT_ALREADY_EXIST:
    void;
};

/******* Payment Result ********/

enum PaymentResultCode
{
    // codes considered as "success" for the operation
    PAYMENT_SUCCESS = 0, // payment successfully completed

    // codes considered as "failure" for the operation
    PAYMENT_MALFORMED = -1,          // bad input
    PAYMENT_UNDERFUNDED = -2,        // not enough funds in source account
    PAYMENT_SRC_NO_TRUST = -3,       // no trust line on source account
    PAYMENT_SRC_NOT_AUTHORIZED = -4, // source not authorized to transfer
    PAYMENT_NO_DESTINATION = -5,     // destination account does not exist
    PAYMENT_NO_TRUST = -6,       // destination missing a trust line for asset
    PAYMENT_NOT_AUTHORIZED = -7, // destination not authorized to hold asset
    PAYMENT_LINE_FULL = -8,      // destination would go above their limit
    PAYMENT_NO_ISSUER = -9       // missing issuer on asset
};

union PaymentResult switch (PaymentResultCode code)
{
case PAYMENT_SUCCESS:
    void;
case PAYMENT_MALFORMED:
case PAYMENT_UNDERFUNDED:
case PAYMENT_SRC_NO_TRUST:
case PAYMENT_SRC_NOT_AUTHORIZED:
case PAYMENT_NO_DESTINATION:
case PAYMENT_NO_TRUST:
case PAYMENT_NOT_AUTHORIZED:
case PAYMENT_LINE_FULL:
case PAYMENT_NO_ISSUER:
    void;
};

/******* PathPaymentStrictReceive Result ********/

enum PathPaymentStrictReceiveResultCode
{
    // codes considered as "success" for the operation
    PATH_PAYMENT_STRICT_RECEIVE_SUCCESS = 0, // success

    // codes considered as "failure" for the operation
    PATH_PAYMENT_STRICT_RECEIVE_MALFORMED = -1, // bad input
    PATH_PAYMENT_STRICT_RECEIVE_UNDERFUNDED =
        -2, // not enough funds in source account
    PATH_PAYMENT_STRICT_RECEIVE_SRC_NO_TRUST =
        -3, // no trust line on source account
    PATH_PAYMENT_STRICT_RECEIVE_SRC_NOT_AUTHORIZED =
        -4, // source not authorized to transfer
    PATH_PAYMENT_STRICT_RECEIVE_NO_DESTINATION =
        -5, // destination account does not exist
    PATH_PAYMENT_STRICT_RECEIVE_NO_TRUST =
        -6, // dest missing a trust line for asset
    PATH_PAYMENT_STRICT_RECEIVE_NOT_AUTHORIZED =
        -7, // dest not authorized to hold asset
    PATH_PAYMENT_STRICT_RECEIVE_LINE_FULL =
        -8, // dest would go above their limit
    PATH_PAYMENT_STRICT_RECEIVE_NO_ISSUER = -9, // missing issuer on one asset
    PATH_PAYMENT_STRICT_RECEIVE_TOO_FEW_OFFERS =
        -10, // not enough offers to satisfy path
    PATH_PAYMENT_STRICT_RECEIVE_OFFER_CROSS_SELF =
        -11, // would cross one of its own offers
    PATH_PAYMENT_STRICT_RECEIVE_OVER_SENDMAX = -12 // could not satisfy sendmax
};

struct SimplePaymentResult
{
    AccountID destination;
    Asset asset;
    int64 amount;
};

union PathPaymentStrictReceiveResult switch (
    PathPaymentStrictReceiveResultCode code)
{
case PATH_PAYMENT_STRICT_RECEIVE_SUCCESS:
    struct
    {
        ClaimAtom offers<>;
        SimplePaymentResult last;
    } success;
case PATH_PAYMENT_STRICT_RECEIVE_MALFORMED:
case PATH_PAYMENT_STRICT_RECEIVE_UNDERFUNDED:
case PATH_PAYMENT_STRICT_RECEIVE_SRC_NO_TRUST:
case PATH_PAYMENT_STRICT_RECEIVE_SRC_NOT_AUTHORIZED:
case PATH_PAYMENT_STRICT_RECEIVE_NO_DESTINATION:
case PATH_PAYMENT_STRICT_RECEIVE_NO_TRUST:
case PATH_PAYMENT_STRICT_RECEIVE_NOT_AUTHORIZED:
case PATH_PAYMENT_STRICT_RECEIVE_LINE_FULL:
    void;
case PATH_PAYMENT_STRICT_RECEIVE_NO_ISSUER:
    Asset noIssuer; // the asset that caused the error
case PATH_PAYMENT_STRICT_RECEIVE_TOO_FEW_OFFERS:
case PATH_PAYMENT_STRICT_RECEIVE_OFFER_CROSS_SELF:
case PATH_PAYMENT_STRICT_RECEIVE_OVER_SENDMAX:
    void;
};

/******* PathPaymentStrictSend Result ********/

enum PathPaymentStrictSendResultCode
{
    // codes considered as "success" for the operation
    PATH_PAYMENT_STRICT_SEND_SUCCESS = 0, // success

    // codes considered as "failure" for the operation
    PATH_PAYMENT_STRICT_SEND_MALFORMED = -1, // bad input
    PATH_PAYMENT_STRICT_SEND_UNDERFUNDED =
        -2, // not enough funds in source account
    PATH_PAYMENT_STRICT_SEND_SRC_NO_TRUST =
        -3, // no trust line on source account
    PATH_PAYMENT_STRICT_SEND_SRC_NOT_AUTHORIZED =
        -4, // source not authorized to transfer
    PATH_PAYMENT_STRICT_SEND_NO_DESTINATION =
        -5, // destination account does not exist
    PATH_PAYMENT_STRICT_SEND_NO_TRUST =
        -6, // dest missing a trust line for asset
    PATH_PAYMENT_STRICT_SEND_NOT_AUTHORIZED =
        -7, // dest not authorized to hold asset
    PATH_PAYMENT_STRICT_SEND_LINE_FULL = -8, // dest would go above their limit
    PATH_PAYMENT_STRICT_SEND_NO_ISSUER = -9, // missing issuer on one asset
    PATH_PAYMENT_STRICT_SEND_TOO_FEW_OFFERS =
        -10, // not enough offers to satisfy path
    PATH_PAYMENT_STRICT_SEND_OFFER_CROSS_SELF =
        -11, // would cross one of its own offers
    PATH_PAYMENT_STRICT_SEND_UNDER_DESTMIN = -12 // could not satisfy destMin
};

union PathPaymentStrictSendResult switch (PathPaymentStrictSendResultCode code)
{
case PATH_PAYMENT_STRICT_SEND_SUCCESS:
    struct
    {
        ClaimAtom offers<>;
        SimplePaymentResult last;
    } success;
case PATH_PAYMENT_STRICT_SEND_MALFORMED:
case PATH_PAYMENT_STRICT_SEND_UNDERFUNDED:
case PATH_PAYMENT_STRICT_SEND_SRC_NO_TRUST:
case PATH_PAYMENT_STRICT_SEND_SRC_NOT_AUTHORIZED:
case PATH_PAYMENT_STRICT_SEND_NO_DESTINATION:
case PATH_PAYMENT_STRICT_SEND_NO_TRUST:
case PATH_PAYMENT_STRICT_SEND_NOT_AUTHORIZED:
case PATH_PAYMENT_STRICT_SEND_LINE_FULL:
    void;
case PATH_PAYMENT_STRICT_SEND_NO_ISSUER:
    Asset noIssuer; // the asset that caused the error
case PATH_PAYMENT_STRICT_SEND_TOO_FEW_OFFERS:
case PATH_PAYMENT_STRICT_SEND_OFFER_CROSS_SELF:
case PATH_PAYMENT_STRICT_SEND_UNDER_DESTMIN:
    void;
};

/******* ManageSellOffer Result ********/

enum ManageSellOfferResultCode
{
    // codes considered as "success" for the operation
    MANAGE_SELL_OFFER_SUCCESS = 0,

    // codes considered as "failure" for the operation
    MANAGE_SELL_OFFER_MALFORMED = -1, // generated offer would be invalid
    MANAGE_SELL_OFFER_SELL_NO_TRUST =
        -2,                              // no trust line for what we're selling
    MANAGE_SELL_OFFER_BUY_NO_TRUST = -3, // no trust line for what we're buying
    MANAGE_SELL_OFFER_SELL_NOT_AUTHORIZED = -4, // not authorized to sell
    MANAGE_SELL_OFFER_BUY_NOT_AUTHORIZED = -5,  // not authorized to buy
    MANAGE_SELL_OFFER_LINE_FULL = -6, // can't receive more of what it's buying
    MANAGE_SELL_OFFER_UNDERFUNDED = -7, // doesn't hold what it's trying to sell
    MANAGE_SELL_OFFER_CROSS_SELF =
        -8, // would cross an offer from the same user
    MANAGE_SELL_OFFER_SELL_NO_ISSUER = -9, // no issuer for what we're selling
    MANAGE_SELL_OFFER_BUY_NO_ISSUER = -10, // no issuer for what we're buying

    // update errors
    MANAGE_SELL_OFFER_NOT_FOUND =
        -11, // offerID does not match an existing offer

    MANAGE_SELL_OFFER_LOW_RESERVE =
        -12 // not enough funds to create a new Offer
};

enum ManageOfferEffect
{
    MANAGE_OFFER_CREATED = 0,
    MANAGE_OFFER_UPDATED = 1,
    MANAGE_OFFER_DELETED = 2
};

struct ManageOfferSuccessResult
{
    // offers that got claimed while creating this offer
    ClaimAtom offersClaimed<>;

    union switch (ManageOfferEffect effect)
    {
    case MANAGE_OFFER_CREATED:
    case MANAGE_OFFER_UPDATED:
        OfferEntry offer;
    case MANAGE_OFFER_DELETED:
        void;
    }
    offer;
};

union ManageSellOfferResult switch (ManageSellOfferResultCode code)
{
case MANAGE_SELL_OFFER_SUCCESS:
    ManageOfferSuccessResult success;
case MANAGE_SELL_OFFER_MALFORMED:
case MANAGE_SELL_OFFER_SELL_NO_TRUST:
case MANAGE_SELL_OFFER_BUY_NO_TRUST:
case MANAGE_SELL_OFFER_SELL_NOT_AUTHORIZED:
case MANAGE_SELL_OFFER_BUY_NOT_AUTHORIZED:
case MANAGE_SELL_OFFER_LINE_FULL:
case MANAGE_SELL_OFFER_UNDERFUNDED:
case MANAGE_SELL_OFFER_CROSS_SELF:
case MANAGE_SELL_OFFER_SELL_NO_ISSUER:
case MANAGE_SELL_OFFER_BUY_NO_ISSUER:
case MANAGE_SELL_OFFER_NOT_FOUND:
case MANAGE_SELL_OFFER_LOW_RESERVE:
    void;
};

/******* ManageBuyOffer Result ********/

enum ManageBuyOfferResultCode
{
    // codes considered as "success" for the operation
    MANAGE_BUY_OFFER_SUCCESS = 0,

    // codes considered as "failure" for the operation
    MANAGE_BUY_OFFER_MALFORMED = -1,     // generated offer would be invalid
    MANAGE_BUY_OFFER_SELL_NO_TRUST = -2, // no trust line for what we're selling
    MANAGE_BUY_OFFER_BUY_NO_TRUST = -3,  // no trust line for what we're buying
    MANAGE_BUY_OFFER_SELL_NOT_AUTHORIZED = -4, // not authorized to sell
    MANAGE_BUY_OFFER_BUY_NOT_AUTHORIZED = -5,  // not authorized to buy
    MANAGE_BUY_OFFER_LINE_FULL = -6,   // can't receive more of what it's buying
    MANAGE_BUY_OFFER_UNDERFUNDED = -7, // doesn't hold what it's trying to sell
    MANAGE_BUY_OFFER_CROSS_SELF = -8, // would cross an offer from the same user
    MANAGE_BUY_OFFER_SELL_NO_ISSUER = -9, // no issuer for what we're selling
    MANAGE_BUY_OFFER_BUY_NO_ISSUER = -10, // no issuer for what we're buying

    // update errors
    MANAGE_BUY_OFFER_NOT_FOUND =
        -11, // offerID does not match an existing offer

    MANAGE_BUY_OFFER_LOW_RESERVE = -12 // not enough funds to create a new Offer
};

union ManageBuyOfferResult switch (ManageBuyOfferResultCode code)
{
case MANAGE_BUY_OFFER_SUCCESS:
    ManageOfferSuccessResult success;
case MANAGE_BUY_OFFER_MALFORMED:
case MANAGE_BUY_OFFER_SELL_NO_TRUST:
case MANAGE_BUY_OFFER_BUY_NO_TRUST:
case MANAGE_BUY_OFFER_SELL_NOT_AUTHORIZED:
case MANAGE_BUY_OFFER_BUY_NOT_AUTHORIZED:
case MANAGE_BUY_OFFER_LINE_FULL:
case MANAGE_BUY_OFFER_UNDERFUNDED:
case MANAGE_BUY_OFFER_CROSS_SELF:
case MANAGE_BUY_OFFER_SELL_NO_ISSUER:
case MANAGE_BUY_OFFER_BUY_NO_ISSUER:
case MANAGE_BUY_OFFER_NOT_FOUND:
case MANAGE_BUY_OFFER_LOW_RESERVE:
    void;
};

/******* SetOptions Result ********/

enum SetOptionsResultCode
{
    // codes considered as "success" for the operation
    SET_OPTIONS_SUCCESS = 0,
    // codes considered as "failure" for the operation
    SET_OPTIONS_LOW_RESERVE = -1,      // not enough funds to add a signer
    SET_OPTIONS_TOO_MANY_SIGNERS = -2, // max number of signers already reached
    SET_OPTIONS_BAD_FLAGS = -3,        // invalid combination of clear/set flags
    SET_OPTIONS_INVALID_INFLATION = -4,      // inflation account does not exist
    SET_OPTIONS_CANT_CHANGE = -5,            // can no longer change this option
    SET_OPTIONS_UNKNOWN_FLAG = -6,           // can't set an unknown flag
    SET_OPTIONS_THRESHOLD_OUT_OF_RANGE = -7, // bad value for weight/threshold
    SET_OPTIONS_BAD_SIGNER = -8,             // signer cannot be masterkey
    SET_OPTIONS_INVALID_HOME_DOMAIN = -9,    // malformed home domain
    SET_OPTIONS_AUTH_REVOCABLE_REQUIRED =
        -10 // auth revocable is required for clawback
};

union SetOptionsResult switch (SetOptionsResultCode code)
{
case SET_OPTIONS_SUCCESS:
    void;
case SET_OPTIONS_LOW_RESERVE:
case SET_OPTIONS_TOO_MANY_SIGNERS:
case SET_OPTIONS_BAD_FLAGS:
case SET_OPTIONS_INVALID_INFLATION:
case SET_OPTIONS_CANT_CHANGE:
case SET_OPTIONS_UNKNOWN_FLAG:
case SET_OPTIONS_THRESHOLD_OUT_OF_RANGE:
case SET_OPTIONS_BAD_SIGNER:
case SET_OPTIONS_INVALID_HOME_DOMAIN:
case SET_OPTIONS_AUTH_REVOCABLE_REQUIRED:
    void;
};

/******* ChangeTrust Result ********/

enum ChangeTrustResultCode
{
    // codes considered as "success" for the operation
    CHANGE_TRUST_SUCCESS = 0,
    // codes considered as "failure" for the operation
    CHANGE_TRUST_MALFORMED = -1,     // bad input
    CHANGE_TRUST_NO_ISSUER = -2,     // could not find issuer
    CHANGE_TRUST_INVALID_LIMIT = -3, // cannot drop limit below balance
                                     // cannot create with a limit of 0
    CHANGE_TRUST_LOW_RESERVE =
        -4, // not enough funds to create a new trust line,
    CHANGE_TRUST_SELF_NOT_ALLOWED = -5,   // trusting self is not allowed
    CHANGE_TRUST_TRUST_LINE_MISSING = -6, // Asset trustline is missing for pool
    CHANGE_TRUST_CANNOT_DELETE =
        -7, // Asset trustline is still referenced in a pool
    CHANGE_TRUST_NOT_AUTH_MAINTAIN_LIABILITIES =
        -8 // Asset trustline is deauthorized
};

union ChangeTrustResult switch (ChangeTrustResultCode code)
{
case CHANGE_TRUST_SUCCESS:
    void;
case CHANGE_TRUST_MALFORMED:
case CHANGE_TRUST_NO_ISSUER:
case CHANGE_TRUST_INVALID_LIMIT:
case CHANGE_TRUST_LOW_RESERVE:
case CHANGE_TRUST_SELF_NOT_ALLOWED:
case CHANGE_TRUST_TRUST_LINE_MISSING:
case CHANGE_TRUST_CANNOT_DELETE:
case CHANGE_TRUST_NOT_AUTH_MAINTAIN_LIABILITIES:
    void;
};

/******* AllowTrust Result ********/

enum AllowTrustResultCode
{
    // codes considered as "success" for the operation
    ALLOW_TRUST_SUCCESS = 0,
    // codes considered as "failure" for the operation
    ALLOW_TRUST_MALFORMED = -1,     // asset is not ASSET_TYPE_ALPHANUM
    ALLOW_TRUST_NO_TRUST_LINE = -2, // trustor does not have a trustline
                                    // source account does not require trust
    ALLOW_TRUST_TRUST_NOT_REQUIRED = -3,
    ALLOW_TRUST_CANT_REVOKE = -4,      // source account can't revoke trust,
    ALLOW_TRUST_SELF_NOT_ALLOWED = -5, // trusting self is not allowed
    ALLOW_TRUST_LOW_RESERVE = -6       // claimable balances can't be created
                                       // on revoke due to low reserves
};

union AllowTrustResult switch (AllowTrustResultCode code)
{
case ALLOW_TRUST_SUCCESS:
    void;
case ALLOW_TRUST_MALFORMED:
case ALLOW_TRUST_NO_TRUST_LINE:
case ALLOW_TRUST_TRUST_NOT_REQUIRED:
case ALLOW_TRUST_CANT_REVOKE:
case ALLOW_TRUST_SELF_NOT_ALLOWED:
case ALLOW_TRUST_LOW_RESERVE:
    void;
};

/******* AccountMerge Result ********/

enum AccountMergeResultCode
{
    // codes considered as "success" for the operation
    ACCOUNT_MERGE_SUCCESS = 0,
    // codes considered as "failure" for the operation
    ACCOUNT_MERGE_MALFORMED = -1,       // can't merge onto itself
    ACCOUNT_MERGE_NO_ACCOUNT = -2,      // destination does not exist
    ACCOUNT_MERGE_IMMUTABLE_SET = -3,   // source account has AUTH_IMMUTABLE set
    ACCOUNT_MERGE_HAS_SUB_ENTRIES = -4, // account has trust lines/offers
    ACCOUNT_MERGE_SEQNUM_TOO_FAR = -5,  // sequence number is over max allowed
    ACCOUNT_MERGE_DEST_FULL = -6,       // can't add source balance to
                                        // destination balance
    ACCOUNT_MERGE_IS_SPONSOR = -7       // can't merge account that is a sponsor
};

union AccountMergeResult switch (AccountMergeResultCode code)
{
case ACCOUNT_MERGE_SUCCESS:
    int64 sourceAccountBalance; // how much got transferred from source account
case ACCOUNT_MERGE_MALFORMED:
case ACCOUNT_MERGE_NO_ACCOUNT:
case ACCOUNT_MERGE_IMMUTABLE_SET:
case ACCOUNT_MERGE_HAS_SUB_ENTRIES:
case ACCOUNT_MERGE_SEQNUM_TOO_FAR:
case ACCOUNT_MERGE_DEST_FULL:
case ACCOUNT_MERGE_IS_SPONSOR:
    void;
};

/******* Inflation Result ********/

enum InflationResultCode
{
    // codes considered as "success" for the operation
    INFLATION_SUCCESS = 0,
    // codes considered as "failure" for the operation
    INFLATION_NOT_TIME = -1
};

struct InflationPayout // or use PaymentResultAtom to limit types?
{
    AccountID destination;
    int64 amount;
};

union InflationResult switch (InflationResultCode code)
{
case INFLATION_SUCCESS:
    InflationPayout payouts<>;
case INFLATION_NOT_TIME:
    void;
};

/******* ManageData Result ********/

enum ManageDataResultCode
{
    // codes considered as "success" for the operation
    MANAGE_DATA_SUCCESS = 0,
    // codes considered as "failure" for the operation
    MANAGE_DATA_NOT_SUPPORTED_YET =
        -1, // The network hasn't moved to this protocol change yet
    MANAGE_DATA_NAME_NOT_FOUND =
        -2, // Trying to remove a Data Entry that isn't there
    MANAGE_DATA_LOW_RESERVE = -3, // not enough funds to create a new Data Entry
    MANAGE_DATA_INVALID_NAME = -4 // Name not a valid string
};

union ManageDataResult switch (ManageDataResultCode code)
{
case MANAGE_DATA_SUCCESS:
    void;
case MANAGE_DATA_NOT_SUPPORTED_YET:
case MANAGE_DATA_NAME_NOT_FOUND:
case MANAGE_DATA_LOW_RESERVE:
case MANAGE_DATA_INVALID_NAME:
    void;
};

/******* BumpSequence Result ********/

enum BumpSequenceResultCode
{
    // codes considered as "success" for the operation
    BUMP_SEQUENCE_SUCCESS = 0,
    // codes considered as "failure" for the operation
    BUMP_SEQUENCE_BAD_SEQ = -1 // `bumpTo` is not within bounds
};

union BumpSequenceResult switch (BumpSequenceResultCode code)
{
case BUMP_SEQUENCE_SUCCESS:
    void;
case BUMP_SEQUENCE_BAD_SEQ:
    void;
};

/******* CreateClaimableBalance Result ********/

enum CreateClaimableBalanceResultCode
{
    CREATE_CLAIMABLE_BALANCE_SUCCESS = 0,
    CREATE_CLAIMABLE_BALANCE_MALFORMED = -1,
    CREATE_CLAIMABLE_BALANCE_LOW_RESERVE = -2,
    CREATE_CLAIMABLE_BALANCE_NO_TRUST = -3,
    CREATE_CLAIMABLE_BALANCE_NOT_AUTHORIZED = -4,
    CREATE_CLAIMABLE_BALANCE_UNDERFUNDED = -5
};

union CreateClaimableBalanceResult switch (
    CreateClaimableBalanceResultCode code)
{
case CREATE_CLAIMABLE_BALANCE_SUCCESS:
    ClaimableBalanceID balanceID;
case CREATE_CLAIMABLE_BALANCE_MALFORMED:
case CREATE_CLAIMABLE_BALANCE_LOW_RESERVE:
case CREATE_CLAIMABLE_BALANCE_NO_TRUST:
case CREATE_CLAIMABLE_BALANCE_NOT_AUTHORIZED:
case CREATE_CLAIMABLE_BALANCE_UNDERFUNDED:
    void;
};

/******* ClaimClaimableBalance Result ********/

enum ClaimClaimableBalanceResultCode
{
    CLAIM_CLAIMABLE_BALANCE_SUCCESS = 0,
    CLAIM_CLAIMABLE_BALANCE_DOES_NOT_EXIST = -1,
    CLAIM_CLAIMABLE_BALANCE_CANNOT_CLAIM = -2,
    CLAIM_CLAIMABLE_BALANCE_LINE_FULL = -3,
    CLAIM_CLAIMABLE_BALANCE_NO_TRUST = -4,
    CLAIM_CLAIMABLE_BALANCE_NOT_AUTHORIZED = -5
};

union ClaimClaimableBalanceResult switch (ClaimClaimableBalanceResultCode code)
{
case CLAIM_CLAIMABLE_BALANCE_SUCCESS:
    void;
case CLAIM_CLAIMABLE_BALANCE_DOES_NOT_EXIST:
case CLAIM_CLAIMABLE_BALANCE_CANNOT_CLAIM:
case CLAIM_CLAIMABLE_BALANCE_LINE_FULL:
case CLAIM_CLAIMABLE_BALANCE_NO_TRUST:
case CLAIM_CLAIMABLE_BALANCE_NOT_AUTHORIZED:
    void;
};

/******* BeginSponsoringFutureReserves Result ********/

enum BeginSponsoringFutureReservesResultCode
{
    // codes considered as "success" for the operation
    BEGIN_SPONSORING_FUTURE_RESERVES_SUCCESS = 0,

    // codes considered as "failure" for the operation
    BEGIN_SPONSORING_FUTURE_RESERVES_MALFORMED = -1,
    BEGIN_SPONSORING_FUTURE_RESERVES_ALREADY_SPONSORED = -2,
    BEGIN_SPONSORING_FUTURE_RESERVES_RECURSIVE = -3
};

union BeginSponsoringFutureReservesResult switch (
    BeginSponsoringFutureReservesResultCode code)
{
case BEGIN_SPONSORING_FUTURE_RESERVES_SUCCESS:
    void;
case BEGIN_SPONSORING_FUTURE_RESERVES_MALFORMED:
case BEGIN_SPONSORING_FUTURE_RESERVES_ALREADY_SPONSORED:
case BEGIN_SPONSORING_FUTURE_RESERVES_RECURSIVE:
    void;
};

/******* EndSponsoringFutureReserves Result ********/

enum EndSponsoringFutureReservesResultCode
{
    // codes considered as "success" for the operation
    END_SPONSORING_FUTURE_RESERVES_SUCCESS = 0,

    // codes considered as "failure" for the operation
    END_SPONSORING_FUTURE_RESERVES_NOT_SPONSORED = -1
};

union EndSponsoringFutureReservesResult switch (
    EndSponsoringFutureReservesResultCode code)
{
case END_SPONSORING_FUTURE_RESERVES_SUCCESS:
    void;
case END_SPONSORING_FUTURE_RESERVES_NOT_SPONSORED:
    void;
};

/******* RevokeSponsorship Result ********/

enum RevokeSponsorshipResultCode
{
    // codes considered as "success" for the operation
    REVOKE_SPONSORSHIP_SUCCESS = 0,

    // codes considered as "failure" for the operation
    REVOKE_SPONSORSHIP_DOES_NOT_EXIST = -1,
    REVOKE_SPONSORSHIP_NOT_SPONSOR = -2,
    REVOKE_SPONSORSHIP_LOW_RESERVE = -3,
    REVOKE_SPONSORSHIP_ONLY_TRANSFERABLE = -4,
    REVOKE_SPONSORSHIP_MALFORMED = -5
};

union RevokeSponsorshipResult switch (RevokeSponsorshipResultCode code)
{
case REVOKE_SPONSORSHIP_SUCCESS:
    void;
case REVOKE_SPONSORSHIP_DOES_NOT_EXIST:
case REVOKE_SPONSORSHIP_NOT_SPONSOR:
case REVOKE_SPONSORSHIP_LOW_RESERVE:
case REVOKE_SPONSORSHIP_ONLY_TRANSFERABLE:
case REVOKE_SPONSORSHIP_MALFORMED:
    void;
};

/******* Clawback Result ********/

enum ClawbackResultCode
{
    // codes considered as "success" for the operation
    CLAWBACK_SUCCESS = 0,

    // codes considered as "failure" for the operation
    CLAWBACK_MALFORMED = -1,
    CLAWBACK_NOT_CLAWBACK_ENABLED = -2,
    CLAWBACK_NO_TRUST = -3,
    CLAWBACK_UNDERFUNDED = -4
};

union ClawbackResult switch (ClawbackResultCode code)
{
case CLAWBACK_SUCCESS:
    void;
case CLAWBACK_MALFORMED:
case CLAWBACK_NOT_CLAWBACK_ENABLED:
case CLAWBACK_NO_TRUST:
case CLAWBACK_UNDERFUNDED:
    void;
};

/******* ClawbackClaimableBalance Result ********/

enum ClawbackClaimableBalanceResultCode
{
    // codes considered as "success" for the operation
    CLAWBACK_CLAIMABLE_BALANCE_SUCCESS = 0,

    // codes considered as "failure" for the operation
    CLAWBACK_CLAIMABLE_BALANCE_DOES_NOT_EXIST = -1,
    CLAWBACK_CLAIMABLE_BALANCE_NOT_ISSUER = -2,
    CLAWBACK_CLAIMABLE_BALANCE_NOT_CLAWBACK_ENABLED = -3
};

union ClawbackClaimableBalanceResult switch (
    ClawbackClaimableBalanceResultCode code)
{
case CLAWBACK_CLAIMABLE_BALANCE_SUCCESS:
    void;
case CLAWBACK_CLAIMABLE_BALANCE_DOES_NOT_EXIST:
case CLAWBACK_CLAIMABLE_BALANCE_NOT_ISSUER:
case CLAWBACK_CLAIMABLE_BALANCE_NOT_CLAWBACK_ENABLED:
    void;
};

/******* SetTrustLineFlags Result ********/

enum SetTrustLineFlagsResultCode
{
    // codes considered as "success" for the operation
    SET_TRUST_LINE_FLAGS_SUCCESS = 0,

    // codes considered as "failure" for the operation
    SET_TRUST_LINE_FLAGS_MALFORMED = -1,
    SET_TRUST_LINE_FLAGS_NO_TRUST_LINE = -2,
    SET_TRUST_LINE_FLAGS_CANT_REVOKE = -3,
    SET_TRUST_LINE_FLAGS_INVALID_STATE = -4,
    SET_TRUST_LINE_FLAGS_LOW_RESERVE = -5 // claimable balances can't be created
                                          // on revoke due to low reserves
};

union SetTrustLineFlagsResult switch (SetTrustLineFlagsResultCode code)
{
case SET_TRUST_LINE_FLAGS_SUCCESS:
    void;
case SET_TRUST_LINE_FLAGS_MALFORMED:
case SET_TRUST_LINE_FLAGS_NO_TRUST_LINE:
case SET_TRUST_LINE_FLAGS_CANT_REVOKE:
case SET_TRUST_LINE_FLAGS_INVALID_STATE:
case SET_TRUST_LINE_FLAGS_LOW_RESERVE:
    void;
};

/******* LiquidityPoolDeposit Result ********/

enum LiquidityPoolDepositResultCode
{
    // codes considered as "success" for the operation
    LIQUIDITY_POOL_DEPOSIT_SUCCESS = 0,

    // codes considered as "failure" for the operation
    LIQUIDITY_POOL_DEPOSIT_MALFORMED = -1,      // bad input
    LIQUIDITY_POOL_DEPOSIT_NO_TRUST = -2,       // no trust line for one of the
                                                // assets
    LIQUIDITY_POOL_DEPOSIT_NOT_AUTHORIZED = -3, // not authorized for one of the
                                                // assets
    LIQUIDITY_POOL_DEPOSIT_UNDERFUNDED = -4,    // not enough balance for one of
                                                // the assets
    LIQUIDITY_POOL_DEPOSIT_LINE_FULL = -5,      // pool share trust line doesn't
                                                // have sufficient limit
    LIQUIDITY_POOL_DEPOSIT_BAD_PRICE = -6,      // deposit price outside bounds
    LIQUIDITY_POOL_DEPOSIT_POOL_FULL = -7       // pool reserves are full
};

union LiquidityPoolDepositResult switch (LiquidityPoolDepositResultCode code)
{
case LIQUIDITY_POOL_DEPOSIT_SUCCESS:
    void;
case LIQUIDITY_POOL_DEPOSIT_MALFORMED:
case LIQUIDITY_POOL_DEPOSIT_NO_TRUST:
case LIQUIDITY_POOL_DEPOSIT_NOT_AUTHORIZED:
case LIQUIDITY_POOL_DEPOSIT_UNDERFUNDED:
case LIQUIDITY_POOL_DEPOSIT_LINE_FULL:
case LIQUIDITY_POOL_DEPOSIT_BAD_PRICE:
case LIQUIDITY_POOL_DEPOSIT_POOL_FULL:
    void;
};

/******* LiquidityPoolWithdraw Result ********/

enum LiquidityPoolWithdrawResultCode
{
    // codes considered as "success" for the operation
    LIQUIDITY_POOL_WITHDRAW_SUCCESS = 0,

    // codes considered as "failure" for the operation
    LIQUIDITY_POOL_WITHDRAW_MALFORMED = -1,    // bad input
    LIQUIDITY_POOL_WITHDRAW_NO_TRUST = -2,     // no trust line for one of the
                                               // assets
    LIQUIDITY_POOL_WITHDRAW_UNDERFUNDED = -3,  // not enough balance of the
                                               // pool share
    LIQUIDITY_POOL_WITHDRAW_LINE_FULL = -4,    // would go above limit for one
                                               // of the assets
    LIQUIDITY_POOL_WITHDRAW_UNDER_MINIMUM = -5 // didn't withdraw enough
};

union LiquidityPoolWithdrawResult switch (LiquidityPoolWithdrawResultCode code)
{
case LIQUIDITY_POOL_WITHDRAW_SUCCESS:
    void;
case LIQUIDITY_POOL_WITHDRAW_MALFORMED:
case LIQUIDITY_POOL_WITHDRAW_NO_TRUST:
case LIQUIDITY_POOL_WITHDRAW_UNDERFUNDED:
case LIQUIDITY_POOL_WITHDRAW_LINE_FULL:
case LIQUIDITY_POOL_WITHDRAW_UNDER_MINIMUM:
    void;
};

enum InvokeHostFunctionResultCode
{
    // codes considered as "success" for the operation
    INVOKE_HOST_FUNCTION_SUCCESS = 0,

    // codes considered as "failure" for the operation
    INVOKE_HOST_FUNCTION_MALFORMED = -1,
    INVOKE_HOST_FUNCTION_TRAPPED = -2,
    INVOKE_HOST_FUNCTION_RESOURCE_LIMIT_EXCEEDED = -3,
    INVOKE_HOST_FUNCTION_ENTRY_ARCHIVED = -4,
    INVOKE_HOST_FUNCTION_INSUFFICIENT_REFUNDABLE_FEE = -5
};

union InvokeHostFunctionResult switch (InvokeHostFunctionResultCode code)
{
case INVOKE_HOST_FUNCTION_SUCCESS:
    Hash success; // sha256(InvokeHostFunctionSuccessPreImage)
case INVOKE_HOST_FUNCTION_MALFORMED:
case INVOKE_HOST_FUNCTION_TRAPPED:
case INVOKE_HOST_FUNCTION_RESOURCE_LIMIT_EXCEEDED:
case INVOKE_HOST_FUNCTION_ENTRY_ARCHIVED:
case INVOKE_HOST_FUNCTION_INSUFFICIENT_REFUNDABLE_FEE:
    void;
};

enum ExtendFootprintTTLResultCode
{
    // codes considered as "success" for the operation
    EXTEND_FOOTPRINT_TTL_SUCCESS = 0,

    // codes considered as "failure" for the operation
    EXTEND_FOOTPRINT_TTL_MALFORMED = -1,
    EXTEND_FOOTPRINT_TTL_RESOURCE_LIMIT_EXCEEDED = -2,
    EXTEND_FOOTPRINT_TTL_INSUFFICIENT_REFUNDABLE_FEE = -3
};

union ExtendFootprintTTLResult switch (ExtendFootprintTTLResultCode code)
{
case EXTEND_FOOTPRINT_TTL_SUCCESS:
    void;
case EXTEND_FOOTPRINT_TTL_MALFORMED:
case EXTEND_FOOTPRINT_TTL_RESOURCE_LIMIT_EXCEEDED:
case EXTEND_FOOTPRINT_TTL_INSUFFICIENT_REFUNDABLE_FEE:
    void;
};

enum RestoreFootprintResultCode
{
    // codes considered as "success" for the operation
    RESTORE_FOOTPRINT_SUCCESS = 0,

    // codes considered as "failure" for the operation
    RESTORE_FOOTPRINT_MALFORMED = -1,
    RESTORE_FOOTPRINT_RESOURCE_LIMIT_EXCEEDED = -2,
    RESTORE_FOOTPRINT_INSUFFICIENT_REFUNDABLE_FEE = -3
};

union RestoreFootprintResult switch (RestoreFootprintResultCode code)
{
case RESTORE_FOOTPRINT_SUCCESS:
    void;
case RESTORE_FOOTPRINT_MALFORMED:
case RESTORE_FOOTPRINT_RESOURCE_LIMIT_EXCEEDED:
case RESTORE_FOOTPRINT_INSUFFICIENT_REFUNDABLE_FEE:
    void;
};

/* High level Operation Result */
enum OperationResultCode
{
    opINNER = 0, // inner object result is valid

    opBAD_AUTH = -1,            // too few valid signatures / wrong network
    opNO_ACCOUNT = -2,          // source account was not found
    opNOT_SUPPORTED = -3,       // operation not supported at this time
    opTOO_MANY_SUBENTRIES = -4, // max number of subentries already reached
    opEXCEEDED_WORK_LIMIT = -5, // operation did too much work
    opTOO_MANY_SPONSORING = -6  // account is sponsoring too many entries
};

union OperationResult switch (OperationResultCode code)
{
case opINNER:
    union switch (OperationType type)
    {
    case CREATE_ACCOUNT:
        CreateAccountResult createAccountResult;
    case PAYMENT:
        PaymentResult paymentResult;
    case PATH_PAYMENT_STRICT_RECEIVE:
        PathPaymentStrictReceiveResult pathPaymentStrictReceiveResult;
    case MANAGE_SELL_OFFER:
        ManageSellOfferResult manageSellOfferResult;
    case CREATE_PASSIVE_SELL_OFFER:
        ManageSellOfferResult createPassiveSellOfferResult;
    case SET_OPTIONS:
        SetOptionsResult setOptionsResult;
    case CHANGE_TRUST:
        ChangeTrustResult changeTrustResult;
    case ALLOW_TRUST:
        AllowTrustResult allowTrustResult;
    case ACCOUNT_MERGE:
        AccountMergeResult accountMergeResult;
    case INFLATION:
        InflationResult inflationResult;
    case MANAGE_DATA:
        ManageDataResult manageDataResult;
    case BUMP_SEQUENCE:
        BumpSequenceResult bumpSeqResult;
    case MANAGE_BUY_OFFER:
        ManageBuyOfferResult manageBuyOfferResult;
    case PATH_PAYMENT_STRICT_SEND:
        PathPaymentStrictSendResult pathPaymentStrictSendResult;
    case CREATE_CLAIMABLE_BALANCE:
        CreateClaimableBalanceResult createClaimableBalanceResult;
    case CLAIM_CLAIMABLE_BALANCE:
        ClaimClaimableBalanceResult claimClaimableBalanceResult;
    case BEGIN_SPONSORING_FUTURE_RESERVES:
        BeginSponsoringFutureReservesResult beginSponsoringFutureReservesResult;
    case END_SPONSORING_FUTURE_RESERVES:
        EndSponsoringFutureReservesResult endSponsoringFutureReservesResult;
    case REVOKE_SPONSORSHIP:
        RevokeSponsorshipResult revokeSponsorshipResult;
    case CLAWBACK:
        ClawbackResult clawbackResult;
    case CLAWBACK_CLAIMABLE_BALANCE:
        ClawbackClaimableBalanceResult clawbackClaimableBalanceResult;
    case SET_TRUST_LINE_FLAGS:
        SetTrustLineFlagsResult setTrustLineFlagsResult;
    case LIQUIDITY_POOL_DEPOSIT:
        LiquidityPoolDepositResult liquidityPoolDepositResult;
    case LIQUIDITY_POOL_WITHDRAW:
        LiquidityPoolWithdrawResult liquidityPoolWithdrawResult;
    case INVOKE_HOST_FUNCTION:
        InvokeHostFunctionResult invokeHostFunctionResult;
    case EXTEND_FOOTPRINT_TTL:
        ExtendFootprintTTLResult extendFootprintTTLResult;
    case RESTORE_FOOTPRINT:
        RestoreFootprintResult restoreFootprintResult;
    }
    tr;
case opBAD_AUTH:
case opNO_ACCOUNT:
case opNOT_SUPPORTED:
case opTOO_MANY_SUBENTRIES:
case opEXCEEDED_WORK_LIMIT:
case opTOO_MANY_SPONSORING:
    void;
};

enum TransactionResultCode
{
    txFEE_BUMP_INNER_SUCCESS = 1, // fee bump inner transaction succeeded
    txSUCCESS = 0,                // all operations succeeded

    txFAILED = -1, // one of the operations failed (none were applied)

    txTOO_EARLY = -2,         // ledger closeTime before minTime
    txTOO_LATE = -3,          // ledger closeTime after maxTime
    txMISSING_OPERATION = -4, // no operation was specified
    txBAD_SEQ = -5,           // sequence number does not match source account

    txBAD_AUTH = -6,             // too few valid signatures / wrong network
    txINSUFFICIENT_BALANCE = -7, // fee would bring account below reserve
    txNO_ACCOUNT = -8,           // source account not found
    txINSUFFICIENT_FEE = -9,     // fee is too small
    txBAD_AUTH_EXTRA = -10,      // unused signatures attached to transaction
    txINTERNAL_ERROR = -11,      // an unknown error occurred

    txNOT_SUPPORTED = -12,          // transaction type not supported
    txFEE_BUMP_INNER_FAILED = -13,  // fee bump inner transaction failed
    txBAD_SPONSORSHIP = -14,        // sponsorship not confirmed
    txBAD_MIN_SEQ_AGE_OR_GAP = -15, // minSeqAge or minSeqLedgerGap conditions not met
    txMALFORMED = -16,              // precondition is invalid
    txSOROBAN_INVALID = -17         // soroban-specific preconditions were not met
};

// InnerTransactionResult must be binary compatible with TransactionResult
// because it is be used to represent the result of a Transaction.
struct InnerTransactionResult
{
    // Always 0. Here for binary compatibility.
    int64 feeCharged;

    union switch (TransactionResultCode code)
    {
    // txFEE_BUMP_INNER_SUCCESS is not included
    case txSUCCESS:
    case txFAILED:
        OperationResult results<>;
    case txTOO_EARLY:
    case txTOO_LATE:
    case txMISSING_OPERATION:
    case txBAD_SEQ:
    case txBAD_AUTH:
    case txINSUFFICIENT_BALANCE:
    case txNO_ACCOUNT:
    case txINSUFFICIENT_FEE:
    case txBAD_AUTH_EXTRA:
    case txINTERNAL_ERROR:
    case txNOT_SUPPORTED:
    // txFEE_BUMP_INNER_FAILED is not included
    case txBAD_SPONSORSHIP:
    case txBAD_MIN_SEQ_AGE_OR_GAP:
    case txMALFORMED:
    case txSOROBAN_INVALID:
        void;
    }
    result;

    // reserved for future use
    union switch (int v)
    {
    case 0:
        void;
    }
    ext;
};

struct InnerTransactionResultPair
{
    Hash transactionHash;          // hash of the inner transaction
    InnerTransactionResult result; // result for the inner transaction
};

struct TransactionResult
{
    int64 feeCharged; // actual fee charged for the transaction

    union switch (TransactionResultCode code)
    {
    case txFEE_BUMP_INNER_SUCCESS:
    case txFEE_BUMP_INNER_FAILED:
        InnerTransactionResultPair innerResultPair;
    case txSUCCESS:
    case txFAILED:
        OperationResult results<>;
    case txTOO_EARLY:
    case txTOO_LATE:
    case txMISSING_OPERATION:
    case txBAD_SEQ:
    case txBAD_AUTH:
    case txINSUFFICIENT_BALANCE:
    case txNO_ACCOUNT:
    case txINSUFFICIENT_FEE:
    case txBAD_AUTH_EXTRA:
    case txINTERNAL_ERROR:
    case txNOT_SUPPORTED:
    // case txFEE_BUMP_INNER_FAILED: handled above
    case txBAD_SPONSORSHIP:
    case txBAD_MIN_SEQ_AGE_OR_GAP:
    case txMALFORMED:
    case txSOROBAN_INVALID:
        void;
    }
    result;

    // reserved for future use
    union switch (int v)
    {
    case 0:
        void;
    }
    ext;
};
}

// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-SCP.h"
%#include "xdr/Stellar-transaction.h"

namespace stellar
{

typedef opaque UpgradeType<128>;

enum StellarValueType
{
    STELLAR_VALUE_BASIC = 0,
    STELLAR_VALUE_SIGNED = 1
};

struct LedgerCloseValueSignature
{
    NodeID nodeID;       // which node introduced the value
    Signature signature; // nodeID's signature
};

/* StellarValue is the value used by SCP to reach consensus on a given ledger
 */
struct StellarValue
{
    Hash txSetHash;      // transaction set to apply to previous ledger
    TimePoint closeTime; // network close time

    // upgrades to apply to the previous ledger (usually empty)
    // this is a vector of encoded 'LedgerUpgrade' so that nodes can drop
    // unknown steps during consensus if needed.
    // see notes below on 'LedgerUpgrade' for more detail
    // max size is dictated by number of upgrade types (+ room for future)
    UpgradeType upgrades<6>;

    // reserved for future use
    union switch (StellarValueType v)
    {
    case STELLAR_VALUE_BASIC:
        void;
    case STELLAR_VALUE_SIGNED:
        LedgerCloseValueSignature lcValueSignature;
    }
    ext;
};

const MASK_LEDGER_HEADER_FLAGS = 0x7;

enum LedgerHeaderFlags
{
    DISABLE_LIQUIDITY_POOL_TRADING_FLAG = 0x1,
    DISABLE_LIQUIDITY_POOL_DEPOSIT_FLAG = 0x2,
    DISABLE_LIQUIDITY_POOL_WITHDRAWAL_FLAG = 0x4
};

struct LedgerHeaderExtensionV1
{
    uint32 flags; // LedgerHeaderFlags

    union switch (int v)
    {
    case 0:
        void;
    }
    ext;
};

/* The LedgerHeader is the highest level structure representing the
 * state of a ledger, cryptographically linked to previous ledgers.
 */
struct LedgerHeader
{
    uint32 ledgerVersion;    // the protocol version of the ledger
    Hash previousLedgerHash; // hash of the previous ledger header
    StellarValue scpValue;   // what consensus agreed to
    Hash txSetResultHash;    // the TransactionResultSet that led to this ledger
    Hash bucketListHash;     // hash of the ledger state

    uint32 ledgerSeq; // sequence number of this ledger

    int64 totalCoins; // total number of stroops in existence.
                      // 10,000,000 stroops in 1 XLM

    int64 feePool;       // fees burned since last inflation run
    uint32 inflationSeq; // inflation sequence number

    uint64 idPool; // last used global ID, used for generating objects

    uint32 baseFee;     // base fee per operation in stroops
    uint32 baseReserve; // account base reserve in stroops

    uint32 maxTxSetSize; // maximum size a transaction set can be

    Hash skipList[4]; // hashes of ledgers in the past. allows you to jump back
                      // in time without walking the chain back ledger by ledger
                      // each slot contains the oldest ledger that is mod of
                      // either 50  5000  50000 or 500000 depending on index
                      // skipList[0] mod(50), skipList[1] mod(5000), etc

    // reserved for future use
    union switch (int v)
    {
    case 0:
        void;
    case 1:
        LedgerHeaderExtensionV1 v1;
    }
    ext;
};

/* Ledger upgrades
note that the `upgrades` field from StellarValue is normalized such that
it only contains one entry per LedgerUpgradeType, and entries are sorted
in ascending order
*/
enum LedgerUpgradeType
{
    LEDGER_UPGRADE_VERSION = 1,
    LEDGER_UPGRADE_BASE_FEE = 2,
    LEDGER_UPGRADE_MAX_TX_SET_SIZE = 3,
    LEDGER_UPGRADE_BASE_RESERVE = 4,
    LEDGER_UPGRADE_FLAGS = 5,
    LEDGER_UPGRADE_CONFIG = 6,
    LEDGER_UPGRADE_MAX_SOROBAN_TX_SET_SIZE = 7
};

struct ConfigUpgradeSetKey {
    Hash contractID;
    Hash contentHash;
};

union LedgerUpgrade switch (LedgerUpgradeType type)
{
case LEDGER_UPGRADE_VERSION:
    uint32 newLedgerVersion; // update ledgerVersion
case LEDGER_UPGRADE_BASE_FEE:
    uint32 newBaseFee; // update baseFee
case LEDGER_UPGRADE_MAX_TX_SET_SIZE:
    uint32 newMaxTxSetSize; // update maxTxSetSize
case LEDGER_UPGRADE_BASE_RESERVE:
    uint32 newBaseReserve; // update baseReserve
case LEDGER_UPGRADE_FLAGS:
    uint32 newFlags; // update flags
case LEDGER_UPGRADE_CONFIG:
    // Update arbitrary `ConfigSetting` entries identified by the key.
    ConfigUpgradeSetKey newConfig;
case LEDGER_UPGRADE_MAX_SOROBAN_TX_SET_SIZE:
    // Update ConfigSettingContractExecutionLanesV0.ledgerMaxTxCount without
    // using `LEDGER_UPGRADE_CONFIG`.
    uint32 newMaxSorobanTxSetSize;
};

struct ConfigUpgradeSet {
    ConfigSettingEntry updatedEntry<>;
};

/* Entries used to define the bucket list */
enum BucketEntryType
{
    METAENTRY =
        -1, // At-and-after protocol 11: bucket metadata, should come first.
    LIVEENTRY = 0, // Before protocol 11: created-or-updated;
                   // At-and-after protocol 11: only updated.
    DEADENTRY = 1,
    INITENTRY = 2 // At-and-after protocol 11: only created.
};

struct BucketMetadata
{
    // Indicates the protocol version used to create / merge this bucket.
    uint32 ledgerVersion;

    // reserved for future use
    union switch (int v)
    {
    case 0:
        void;
    }
    ext;
};

union BucketEntry switch (BucketEntryType type)
{
case LIVEENTRY:
case INITENTRY:
    LedgerEntry liveEntry;

case DEADENTRY:
    LedgerKey deadEntry;
case METAENTRY:
    BucketMetadata metaEntry;
};

enum TxSetComponentType
{
  // txs with effective fee <= bid derived from a base fee (if any).
  // If base fee is not specified, no discount is applied.
  TXSET_COMP_TXS_MAYBE_DISCOUNTED_FEE = 0
};

union TxSetComponent switch (TxSetComponentType type)
{
case TXSET_COMP_TXS_MAYBE_DISCOUNTED_FEE:
  struct
  {
    int64* baseFee;
    TransactionEnvelope txs<>;
  } txsMaybeDiscountedFee;
};

union TransactionPhase switch (int v)
{
case 0:
    TxSetComponent v0Components<>;
};

// Transaction sets are the unit used by SCP to decide on transitions
// between ledgers
struct TransactionSet
{
    Hash previousLedgerHash;
    TransactionEnvelope txs<>;
};

struct TransactionSetV1
{
    Hash previousLedgerHash;
    TransactionPhase phases<>;
};

union GeneralizedTransactionSet switch (int v)
{
// We consider the legacy TransactionSet to be v0.
case 1:
    TransactionSetV1 v1TxSet;
};

struct TransactionResultPair
{
    Hash transactionHash;
    TransactionResult result; // result for the transaction
};

// TransactionResultSet is used to recover results between ledgers
struct TransactionResultSet
{
    TransactionResultPair results<>;
};

// Entries below are used in the historical subsystem

struct TransactionHistoryEntry
{
    uint32 ledgerSeq;
    TransactionSet txSet;

    // when v != 0, txSet must be empty
    union switch (int v)
    {
    case 0:
        void;
    case 1:
        GeneralizedTransactionSet generalizedTxSet;
    }
    ext;
};

struct TransactionHistoryResultEntry
{
    uint32 ledgerSeq;
    TransactionResultSet txResultSet;

    // reserved for future use
    union switch (int v)
    {
    case 0:
        void;
    }
    ext;
};

struct LedgerHeaderHistoryEntry
{
    Hash hash;
    LedgerHeader header;

    // reserved for future use
    union switch (int v)
    {
    case 0:
        void;
    }
    ext;
};

// historical SCP messages

struct LedgerSCPMessages
{
    uint32 ledgerSeq;
    SCPEnvelope messages<>;
};

// note: ledgerMessages may refer to any quorumSets encountered
// in the file so far, not just the one from this entry
struct SCPHistoryEntryV0
{
    SCPQuorumSet quorumSets<>; // additional quorum sets used by ledgerMessages
    LedgerSCPMessages ledgerMessages;
};

// SCP history file is an array of these
union SCPHistoryEntry switch (int v)
{
case 0:
    SCPHistoryEntryV0 v0;
};

// represents the meta in the transaction table history

// STATE is emitted every time a ledger entry is modified/deleted
// and the entry was not already modified in the current ledger

enum LedgerEntryChangeType
{
    LEDGER_ENTRY_CREATED = 0, // entry was added to the ledger
    LEDGER_ENTRY_UPDATED = 1, // entry was modified in the ledger
    LEDGER_ENTRY_REMOVED = 2, // entry was removed from the ledger
    LEDGER_ENTRY_STATE = 3    // value of the entry
};

union LedgerEntryChange switch (LedgerEntryChangeType type)
{
case LEDGER_ENTRY_CREATED:
    LedgerEntry created;
case LEDGER_ENTRY_UPDATED:
    LedgerEntry updated;
case LEDGER_ENTRY_REMOVED:
    LedgerKey removed;
case LEDGER_ENTRY_STATE:
    LedgerEntry state;
};

typedef LedgerEntryChange LedgerEntryChanges<>;

struct OperationMeta
{
    LedgerEntryChanges changes;
};

struct TransactionMetaV1
{
    LedgerEntryChanges txChanges; // tx level changes if any
    OperationMeta operations<>;   // meta for each operation
};

struct TransactionMetaV2
{
    LedgerEntryChanges txChangesBefore; // tx level changes before operations
                                        // are applied if any
    OperationMeta operations<>;         // meta for each operation
    LedgerEntryChanges txChangesAfter;  // tx level changes after operations are
                                        // applied if any
};

enum ContractEventType
{
    SYSTEM = 0,
    CONTRACT = 1,
    DIAGNOSTIC = 2
};

struct ContractEvent
{
    // We can use this to add more fields, or because it
    // is first, to change ContractEvent into a union.
    ExtensionPoint ext;

    Hash* contractID;
    ContractEventType type;

    union switch (int v)
    {
    case 0:
        struct
        {
            SCVal topics<>;
            SCVal data;
        } v0;
    }
    body;
};

struct DiagnosticEvent
{
    bool inSuccessfulContractCall;
    ContractEvent event;
};

struct SorobanTransactionMeta 
{
    ExtensionPoint ext;

    ContractEvent events<>;             // custom events populated by the
                                        // contracts themselves.
    SCVal returnValue;                  // return value of the host fn invocation

    // Diagnostics events that are not hashed.
    // This will contain all contract and diagnostic events. Even ones
    // that were emitted in a failed contract call.
    DiagnosticEvent diagnosticEvents<>;
};

struct TransactionMetaV3
{
    ExtensionPoint ext;

    LedgerEntryChanges txChangesBefore;  // tx level changes before operations
                                         // are applied if any
    OperationMeta operations<>;          // meta for each operation
    LedgerEntryChanges txChangesAfter;   // tx level changes after operations are
                                         // applied if any
    SorobanTransactionMeta* sorobanMeta; // Soroban-specific meta (only for 
                                         // Soroban transactions).
};

// This is in Stellar-ledger.x to due to a circular dependency 
struct InvokeHostFunctionSuccessPreImage
{
    SCVal returnValue;
    ContractEvent events<>;
};

// this is the meta produced when applying transactions
// it does not include pre-apply updates such as fees
union TransactionMeta switch (int v)
{
case 0:
    OperationMeta operations<>;
case 1:
    TransactionMetaV1 v1;
case 2:
    TransactionMetaV2 v2;
case 3:
    TransactionMetaV3 v3;
};

// This struct groups together changes on a per transaction basis
// note however that fees and transaction application are done in separate
// phases
struct TransactionResultMeta
{
    TransactionResultPair result;
    LedgerEntryChanges feeProcessing;
    TransactionMeta txApplyProcessing;
};

// this represents a single upgrade that was performed as part of a ledger
// upgrade
struct UpgradeEntryMeta
{
    LedgerUpgrade upgrade;
    LedgerEntryChanges changes;
};

struct LedgerCloseMetaV0
{
    LedgerHeaderHistoryEntry ledgerHeader;
    // NB: txSet is sorted in "Hash order"
    TransactionSet txSet;

    // NB: transactions are sorted in apply order here
    // fees for all transactions are processed first
    // followed by applying transactions
    TransactionResultMeta txProcessing<>;

    // upgrades are applied last
    UpgradeEntryMeta upgradesProcessing<>;

    // other misc information attached to the ledger close
    SCPHistoryEntry scpInfo<>;
};

struct LedgerCloseMetaV1
{
    // We forgot to add an ExtensionPoint in v0 but at least
    // we can add one now in v1.
    ExtensionPoint ext;

    LedgerHeaderHistoryEntry ledgerHeader;

    GeneralizedTransactionSet txSet;

    // NB: transactions are sorted in apply order here
    // fees for all transactions are processed first
    // followed by applying transactions
    TransactionResultMeta txProcessing<>;

    // upgrades are applied last
    UpgradeEntryMeta upgradesProcessing<>;

    // other misc information attached to the ledger close
    SCPHistoryEntry scpInfo<>;

    // Size in bytes of BucketList, to support downstream
    // systems calculating storage fees correctly.
    uint64 totalByteSizeOfBucketList;

    // Temp keys that are being evicted at this ledger.
    LedgerKey evictedTemporaryLedgerKeys<>;

    // Archived restorable ledger entries that are being
    // evicted at this ledger.
    LedgerEntry evictedPersistentLedgerEntries<>;
};

union LedgerCloseMeta switch (int v)
{
case 0:
    LedgerCloseMetaV0 v0;
case 1:
    LedgerCloseMetaV1 v1;
};
}

// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger.h"

namespace stellar
{

enum ErrorCode
{
    ERR_MISC = 0, // Unspecific error
    ERR_DATA = 1, // Malformed data
    ERR_CONF = 2, // Misconfiguration error
    ERR_AUTH = 3, // Authentication failure
    ERR_LOAD = 4  // System overloaded
};

struct Error
{
    ErrorCode code;
    string msg<100>;
};

struct SendMore
{
    uint32 numMessages;
};

struct SendMoreExtended
{
    uint32 numMessages;
    uint32 numBytes;
};

struct AuthCert
{
    Curve25519Public pubkey;
    uint64 expiration;
    Signature sig;
};

struct Hello
{
    uint32 ledgerVersion;
    uint32 overlayVersion;
    uint32 overlayMinVersion;
    Hash networkID;
    string versionStr<100>;
    int listeningPort;
    NodeID peerID;
    AuthCert cert;
    uint256 nonce;
};

// During the roll-out phrase, nodes can disable flow control in bytes.
// Therefore, we need a way to communicate with other nodes
// that we want/don't want flow control in bytes.
// We use the `flags` field in the Auth message with a special value
// set to communicate this. Note that AUTH_MSG_FLAG_FLOW_CONTROL_BYTES_REQUESTED != 0
// AND AUTH_MSG_FLAG_FLOW_CONTROL_BYTES_REQUESTED != 100 (as previously
// that value was used for other purposes).
const AUTH_MSG_FLAG_FLOW_CONTROL_BYTES_REQUESTED = 200;

struct Auth
{
    int flags;
};

enum IPAddrType
{
    IPv4 = 0,
    IPv6 = 1
};

struct PeerAddress
{
    union switch (IPAddrType type)
    {
    case IPv4:
        opaque ipv4[4];
    case IPv6:
        opaque ipv6[16];
    }
    ip;
    uint32 port;
    uint32 numFailures;
};

// Next ID: 21
enum MessageType
{
    ERROR_MSG = 0,
    AUTH = 2,
    DONT_HAVE = 3,

    GET_PEERS = 4, // gets a list of peers this guy knows about
    PEERS = 5,

    GET_TX_SET = 6, // gets a particular txset by hash
    TX_SET = 7,
    GENERALIZED_TX_SET = 17,

    TRANSACTION = 8, // pass on a tx you have heard about

    // SCP
    GET_SCP_QUORUMSET = 9,
    SCP_QUORUMSET = 10,
    SCP_MESSAGE = 11,
    GET_SCP_STATE = 12,

    // new messages
    HELLO = 13,

    SURVEY_REQUEST = 14,
    SURVEY_RESPONSE = 15,

    SEND_MORE = 16,
    SEND_MORE_EXTENDED = 20,

    FLOOD_ADVERT = 18,
    FLOOD_DEMAND = 19
};

struct DontHave
{
    MessageType type;
    uint256 reqHash;
};

enum SurveyMessageCommandType
{
    SURVEY_TOPOLOGY = 0
};

enum SurveyMessageResponseType
{
    SURVEY_TOPOLOGY_RESPONSE_V0 = 0,
    SURVEY_TOPOLOGY_RESPONSE_V1 = 1
};

struct SurveyRequestMessage
{
    NodeID surveyorPeerID;
    NodeID surveyedPeerID;
    uint32 ledgerNum;
    Curve25519Public encryptionKey;
    SurveyMessageCommandType commandType;
};

struct SignedSurveyRequestMessage
{
    Signature requestSignature;
    SurveyRequestMessage request;
};

typedef opaque EncryptedBody<64000>;
struct SurveyResponseMessage
{
    NodeID surveyorPeerID;
    NodeID surveyedPeerID;
    uint32 ledgerNum;
    SurveyMessageCommandType commandType;
    EncryptedBody encryptedBody;
};

struct SignedSurveyResponseMessage
{
    Signature responseSignature;
    SurveyResponseMessage response;
};

struct PeerStats
{
    NodeID id;
    string versionStr<100>;
    uint64 messagesRead;
    uint64 messagesWritten;
    uint64 bytesRead;
    uint64 bytesWritten;
    uint64 secondsConnected;

    uint64 uniqueFloodBytesRecv;
    uint64 duplicateFloodBytesRecv;
    uint64 uniqueFetchBytesRecv;
    uint64 duplicateFetchBytesRecv;

    uint64 uniqueFloodMessageRecv;
    uint64 duplicateFloodMessageRecv;
    uint64 uniqueFetchMessageRecv;
    uint64 duplicateFetchMessageRecv;
};

typedef PeerStats PeerStatList<25>;

struct TopologyResponseBodyV0
{
    PeerStatList inboundPeers;
    PeerStatList outboundPeers;

    uint32 totalInboundPeerCount;
    uint32 totalOutboundPeerCount;
};

struct TopologyResponseBodyV1
{
    PeerStatList inboundPeers;
    PeerStatList outboundPeers;

    uint32 totalInboundPeerCount;
    uint32 totalOutboundPeerCount;

    uint32 maxInboundPeerCount;
    uint32 maxOutboundPeerCount;
};

union SurveyResponseBody switch (SurveyMessageResponseType type)
{
case SURVEY_TOPOLOGY_RESPONSE_V0:
    TopologyResponseBodyV0 topologyResponseBodyV0;
case SURVEY_TOPOLOGY_RESPONSE_V1:
    TopologyResponseBodyV1 topologyResponseBodyV1;
};

const TX_ADVERT_VECTOR_MAX_SIZE = 1000;
typedef Hash TxAdvertVector<TX_ADVERT_VECTOR_MAX_SIZE>;

struct FloodAdvert
{
    TxAdvertVector txHashes;
};

const TX_DEMAND_VECTOR_MAX_SIZE = 1000;
typedef Hash TxDemandVector<TX_DEMAND_VECTOR_MAX_SIZE>;

struct FloodDemand
{
    TxDemandVector txHashes;
};

union StellarMessage switch (MessageType type)
{
case ERROR_MSG:
    Error error;
case HELLO:
    Hello hello;
case AUTH:
    Auth auth;
case DONT_HAVE:
    DontHave dontHave;
case GET_PEERS:
    void;
case PEERS:
    PeerAddress peers<100>;

case GET_TX_SET:
    uint256 txSetHash;
case TX_SET:
    TransactionSet txSet;
case GENERALIZED_TX_SET:
    GeneralizedTransactionSet generalizedTxSet;

case TRANSACTION:
    TransactionEnvelope transaction;

case SURVEY_REQUEST:
    SignedSurveyRequestMessage signedSurveyRequestMessage;

case SURVEY_RESPONSE:
    SignedSurveyResponseMessage signedSurveyResponseMessage;

// SCP
case GET_SCP_QUORUMSET:
    uint256 qSetHash;
case SCP_QUORUMSET:
    SCPQuorumSet qSet;
case SCP_MESSAGE:
    SCPEnvelope envelope;
case GET_SCP_STATE:
    uint32 getSCPLedgerSeq; // ledger seq requested ; if 0, requests the latest
case SEND_MORE:
    SendMore sendMoreMessage;
case SEND_MORE_EXTENDED:
    SendMoreExtended sendMoreExtendedMessage;
// Pull mode
case FLOOD_ADVERT:
     FloodAdvert floodAdvert;
case FLOOD_DEMAND:
     FloodDemand floodDemand;
};

union AuthenticatedMessage switch (uint32 v)
{
case 0:
    struct
    {
        uint64 sequence;
        StellarMessage message;
        HmacSha256Mac mac;
    } v0;
};
}

// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"

namespace stellar
{

typedef opaque Value<>;

struct SCPBallot
{
    uint32 counter; // n
    Value value;    // x
};

enum SCPStatementType
{
    SCP_ST_PREPARE = 0,
    SCP_ST_CONFIRM = 1,
    SCP_ST_EXTERNALIZE = 2,
    SCP_ST_NOMINATE = 3
};

struct SCPNomination
{
    Hash quorumSetHash; // D
    Value votes<>;      // X
    Value accepted<>;   // Y
};

struct SCPStatement
{
    NodeID nodeID;    // v
    uint64 slotIndex; // i

    union switch (SCPStatementType type)
    {
    case SCP_ST_PREPARE:
        struct
        {
            Hash quorumSetHash;       // D
            SCPBallot ballot;         // b
            SCPBallot* prepared;      // p
            SCPBallot* preparedPrime; // p'
            uint32 nC;                // c.n
            uint32 nH;                // h.n
        } prepare;
    case SCP_ST_CONFIRM:
        struct
        {
            SCPBallot ballot;   // b
            uint32 nPrepared;   // p.n
            uint32 nCommit;     // c.n
            uint32 nH;          // h.n
            Hash quorumSetHash; // D
        } confirm;
    case SCP_ST_EXTERNALIZE:
        struct
        {
            SCPBallot commit;         // c
            uint32 nH;                // h.n
            Hash commitQuorumSetHash; // D used before EXTERNALIZE
        } externalize;
    case SCP_ST_NOMINATE:
        SCPNomination nominate;
    }
    pledges;
};

struct SCPEnvelope
{
    SCPStatement statement;
    Signature signature;
};

// supports things like: A,B,C,(D,E,F),(G,H,(I,J,K,L))
// only allows 2 levels of nesting
struct SCPQuorumSet
{
    uint32 threshold;
    NodeID validators<>;
    SCPQuorumSet innerSets<>;
};
}

// Copyright 2022 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

// This is for 'internal'-only messages that are not meant to be read/written
// by any other binaries besides a single Core instance.
%#include "xdr/Stellar-ledger.h"
%#include "xdr/Stellar-SCP.h"

namespace stellar
{
union StoredTransactionSet switch (int v)
{
case 0:
	TransactionSet txSet;
case 1:
	GeneralizedTransactionSet generalizedTxSet;
};

struct StoredDebugTransactionSet
{
	StoredTransactionSet txSet;
	uint32 ledgerSeq;
	StellarValue scpValue;
};

struct PersistedSCPStateV0
{
	SCPEnvelope scpEnvelopes<>;
	SCPQuorumSet quorumSets<>;
	StoredTransactionSet txSets<>;
};

struct PersistedSCPStateV1
{
	// Tx sets are saved separately
	SCPEnvelope scpEnvelopes<>;
	SCPQuorumSet quorumSets<>;
};

union PersistedSCPState switch (int v)
{
case 0:
	PersistedSCPStateV0 v0;
case 1:
	PersistedSCPStateV1 v1;
};
}
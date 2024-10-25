# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SCValType
#   {
#       SCV_BOOL = 0,
#       SCV_VOID = 1,
#       SCV_STATUS = 2,
#   
#       // 32 bits is the smallest type in WASM or XDR; no need for u8/u16.
#       SCV_U32 = 3,
#       SCV_I32 = 4,
#   
#       // 64 bits is naturally supported by both WASM and XDR also.
#       SCV_U64 = 5,
#       SCV_I64 = 6,
#   
#       // Time-related u64 subtypes with their own functions and formatting.
#       SCV_TIMEPOINT = 7,
#       SCV_DURATION = 8,
#   
#       // 128 bits is naturally supported by Rust and we use it for Soroban
#       // fixed-point arithmetic prices / balances / similar "quantities". These
#       // are represented in XDR as a pair of 2 u64s, unlike {u,i}256 which is
#       // represented as an array of 32 bytes.
#       SCV_U128 = 9,
#       SCV_I128 = 10,
#   
#       // 256 bits is the size of sha256 output, ed25519 keys, and the EVM machine
#       // word, so for interop use we include this even though it requires a small
#       // amount of Rust guest and/or host library code.
#       SCV_U256 = 11,
#       SCV_I256 = 12,
#   
#       // TODO: possibly allocate subtypes of i64, i128 and/or u256 for
#       // fixed-precision with a specific number of decimals.
#   
#       // Bytes come in 3 flavors, 2 of which have meaningfully different
#       // formatting and validity-checking / domain-restriction.
#       SCV_BYTES = 13,
#       SCV_STRING = 14,
#       SCV_SYMBOL = 15,
#   
#       // Vecs and maps are just polymorphic containers of other ScVals.
#       SCV_VEC = 16,
#       SCV_MAP = 17,
#   
#       // SCContractExecutable and SCAddressType are types that gets used separately from
#       // SCVal so we do not flatten their structures into separate SCVal cases.
#       SCV_CONTRACT_EXECUTABLE = 18,
#       SCV_ADDRESS = 19,
#   
#       // SCV_LEDGER_KEY_CONTRACT_EXECUTABLE and SCV_LEDGER_KEY_NONCE are unique
#       // symbolic SCVals used as the key for ledger entries for a contract's code
#       // and an address' nonce, respectively.
#       SCV_LEDGER_KEY_CONTRACT_EXECUTABLE = 20,
#       SCV_LEDGER_KEY_NONCE = 21
#   };
#
# ===========================================================================
module Stellar
  class SCValType < XDR::Enum
    member :scv_bool,                           0
    member :scv_void,                           1
    member :scv_status,                         2
    member :scv_u32,                            3
    member :scv_i32,                            4
    member :scv_u64,                            5
    member :scv_i64,                            6
    member :scv_timepoint,                      7
    member :scv_duration,                       8
    member :scv_u128,                           9
    member :scv_i128,                           10
    member :scv_u256,                           11
    member :scv_i256,                           12
    member :scv_bytes,                          13
    member :scv_string,                         14
    member :scv_symbol,                         15
    member :scv_vec,                            16
    member :scv_map,                            17
    member :scv_contract_executable,            18
    member :scv_address,                        19
    member :scv_ledger_key_contract_executable, 20
    member :scv_ledger_key_nonce,               21

    seal
  end
end

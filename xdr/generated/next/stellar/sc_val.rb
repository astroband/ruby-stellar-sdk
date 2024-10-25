# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union SCVal switch (SCValType type)
#   {
#   
#   case SCV_BOOL:
#       bool b;
#   case SCV_VOID:
#       void;
#   case SCV_STATUS:
#       SCStatus error;
#   
#   case SCV_U32:
#       uint32 u32;
#   case SCV_I32:
#       int32 i32;
#   
#   case SCV_U64:
#       uint64 u64;
#   case SCV_I64:
#       int64 i64;
#   case SCV_TIMEPOINT:
#       TimePoint timepoint;
#   case SCV_DURATION:
#       Duration duration;
#   
#   case SCV_U128:
#       Int128Parts u128;
#   case SCV_I128:
#       Int128Parts i128;
#   
#   case SCV_U256:
#       uint256 u256;
#   case SCV_I256:
#       uint256 i256;
#   
#   case SCV_BYTES:
#       SCBytes bytes;
#   case SCV_STRING:
#       SCString str;
#   case SCV_SYMBOL:
#       SCSymbol sym;
#   
#   // Vec and Map are recursive so need to live
#   // behind an option, due to xdrpp limitations.
#   case SCV_VEC:
#       SCVec *vec;
#   case SCV_MAP:
#       SCMap *map;
#   
#   case SCV_CONTRACT_EXECUTABLE:
#       SCContractExecutable exec;
#   case SCV_ADDRESS:
#       SCAddress address;
#   
#   // Special SCVals reserved for system-constructed contract-data
#   // ledger keys, not generally usable elsewhere.
#   case SCV_LEDGER_KEY_CONTRACT_EXECUTABLE:
#       void;
#   case SCV_LEDGER_KEY_NONCE:
#       SCNonceKey nonce_key;
#   };
#
# ===========================================================================
module Stellar
  class SCVal < XDR::Union
    switch_on SCValType, :type

    switch :scv_bool,                         :b
    switch :scv_void
    switch :scv_status,                       :error
    switch :scv_u32,                          :u32
    switch :scv_i32,                          :i32
    switch :scv_u64,                          :u64
    switch :scv_i64,                          :i64
    switch :scv_timepoint,                    :timepoint
    switch :scv_duration,                     :duration
    switch :scv_u128,                         :u128
    switch :scv_i128,                         :i128
    switch :scv_u256,                         :u256
    switch :scv_i256,                         :i256
    switch :scv_bytes,                        :bytes
    switch :scv_string,                       :str
    switch :scv_symbol,                       :sym
    switch :scv_vec,                          :vec
    switch :scv_map,                          :map
    switch :scv_contract_executable,          :exec
    switch :scv_address,                      :address
    switch :scv_ledger_key_contract_executable
    switch :scv_ledger_key_nonce,             :nonce_key

    attribute :b,         XDR::Bool
    attribute :error,     SCStatus
    attribute :u32,       Uint32
    attribute :i32,       Int32
    attribute :u64,       Uint64
    attribute :i64,       Int64
    attribute :timepoint, TimePoint
    attribute :duration,  Duration
    attribute :u128,      Int128Parts
    attribute :i128,      Int128Parts
    attribute :u256,      Uint256
    attribute :i256,      Uint256
    attribute :bytes,     SCBytes
    attribute :str,       SCString
    attribute :sym,       SCSymbol
    attribute :vec,       XDR::Option[SCVec]
    attribute :map,       XDR::Option[SCMap]
    attribute :exec,      SCContractExecutable
    attribute :address,   SCAddress
    attribute :nonce_key, SCNonceKey
  end
end

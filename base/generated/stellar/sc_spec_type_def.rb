# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union SCSpecTypeDef switch (SCSpecType type)
#   {
#   case SC_SPEC_TYPE_VAL:
#   case SC_SPEC_TYPE_BOOL:
#   case SC_SPEC_TYPE_VOID:
#   case SC_SPEC_TYPE_ERROR:
#   case SC_SPEC_TYPE_U32:
#   case SC_SPEC_TYPE_I32:
#   case SC_SPEC_TYPE_U64:
#   case SC_SPEC_TYPE_I64:
#   case SC_SPEC_TYPE_TIMEPOINT:
#   case SC_SPEC_TYPE_DURATION:
#   case SC_SPEC_TYPE_U128:
#   case SC_SPEC_TYPE_I128:
#   case SC_SPEC_TYPE_U256:
#   case SC_SPEC_TYPE_I256:
#   case SC_SPEC_TYPE_BYTES:
#   case SC_SPEC_TYPE_STRING:
#   case SC_SPEC_TYPE_SYMBOL:
#   case SC_SPEC_TYPE_ADDRESS:
#       void;
#   case SC_SPEC_TYPE_OPTION:
#       SCSpecTypeOption option;
#   case SC_SPEC_TYPE_RESULT:
#       SCSpecTypeResult result;
#   case SC_SPEC_TYPE_VEC:
#       SCSpecTypeVec vec;
#   case SC_SPEC_TYPE_MAP:
#       SCSpecTypeMap map;
#   case SC_SPEC_TYPE_TUPLE:
#       SCSpecTypeTuple tuple;
#   case SC_SPEC_TYPE_BYTES_N:
#       SCSpecTypeBytesN bytesN;
#   case SC_SPEC_TYPE_UDT:
#       SCSpecTypeUDT udt;
#   };
#
# ===========================================================================
module Stellar
  class SCSpecTypeDef < XDR::Union
    switch_on SCSpecType, :type

    switch :sc_spec_type_val
    switch :sc_spec_type_bool
    switch :sc_spec_type_void
    switch :sc_spec_type_error
    switch :sc_spec_type_u32
    switch :sc_spec_type_i32
    switch :sc_spec_type_u64
    switch :sc_spec_type_i64
    switch :sc_spec_type_timepoint
    switch :sc_spec_type_duration
    switch :sc_spec_type_u128
    switch :sc_spec_type_i128
    switch :sc_spec_type_u256
    switch :sc_spec_type_i256
    switch :sc_spec_type_bytes
    switch :sc_spec_type_string
    switch :sc_spec_type_symbol
    switch :sc_spec_type_address
    switch :sc_spec_type_option,  :option
    switch :sc_spec_type_result,  :result
    switch :sc_spec_type_vec,     :vec
    switch :sc_spec_type_map,     :map
    switch :sc_spec_type_tuple,   :tuple
    switch :sc_spec_type_bytes_n, :bytes_n
    switch :sc_spec_type_udt,     :udt

    attribute :option,  SCSpecTypeOption
    attribute :result,  SCSpecTypeResult
    attribute :vec,     SCSpecTypeVec
    attribute :map,     SCSpecTypeMap
    attribute :tuple,   SCSpecTypeTuple
    attribute :bytes_n, SCSpecTypeBytesN
    attribute :udt,     SCSpecTypeUDT
  end
end

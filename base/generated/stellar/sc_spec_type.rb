# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SCSpecType
#   {
#       SC_SPEC_TYPE_VAL = 0,
#
#       // Types with no parameters.
#       SC_SPEC_TYPE_BOOL = 1,
#       SC_SPEC_TYPE_VOID = 2,
#       SC_SPEC_TYPE_ERROR = 3,
#       SC_SPEC_TYPE_U32 = 4,
#       SC_SPEC_TYPE_I32 = 5,
#       SC_SPEC_TYPE_U64 = 6,
#       SC_SPEC_TYPE_I64 = 7,
#       SC_SPEC_TYPE_TIMEPOINT = 8,
#       SC_SPEC_TYPE_DURATION = 9,
#       SC_SPEC_TYPE_U128 = 10,
#       SC_SPEC_TYPE_I128 = 11,
#       SC_SPEC_TYPE_U256 = 12,
#       SC_SPEC_TYPE_I256 = 13,
#       SC_SPEC_TYPE_BYTES = 14,
#       SC_SPEC_TYPE_STRING = 16,
#       SC_SPEC_TYPE_SYMBOL = 17,
#       SC_SPEC_TYPE_ADDRESS = 19,
#
#       // Types with parameters.
#       SC_SPEC_TYPE_OPTION = 1000,
#       SC_SPEC_TYPE_RESULT = 1001,
#       SC_SPEC_TYPE_VEC = 1002,
#       SC_SPEC_TYPE_MAP = 1004,
#       SC_SPEC_TYPE_TUPLE = 1005,
#       SC_SPEC_TYPE_BYTES_N = 1006,
#
#       // User defined types.
#       SC_SPEC_TYPE_UDT = 2000
#   };
#
# ===========================================================================
module Stellar
  class SCSpecType < XDR::Enum
    member :sc_spec_type_val,       0
    member :sc_spec_type_bool,      1
    member :sc_spec_type_void,      2
    member :sc_spec_type_error,     3
    member :sc_spec_type_u32,       4
    member :sc_spec_type_i32,       5
    member :sc_spec_type_u64,       6
    member :sc_spec_type_i64,       7
    member :sc_spec_type_timepoint, 8
    member :sc_spec_type_duration,  9
    member :sc_spec_type_u128,      10
    member :sc_spec_type_i128,      11
    member :sc_spec_type_u256,      12
    member :sc_spec_type_i256,      13
    member :sc_spec_type_bytes,     14
    member :sc_spec_type_string,    16
    member :sc_spec_type_symbol,    17
    member :sc_spec_type_address,   19
    member :sc_spec_type_option,    1000
    member :sc_spec_type_result,    1001
    member :sc_spec_type_vec,       1002
    member :sc_spec_type_map,       1004
    member :sc_spec_type_tuple,     1005
    member :sc_spec_type_bytes_n,   1006
    member :sc_spec_type_udt,       2000

    seal
  end
end

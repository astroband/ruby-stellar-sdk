# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SCHostValErrorCode
#   {
#       HOST_VALUE_UNKNOWN_ERROR = 0,
#       HOST_VALUE_RESERVED_TAG_VALUE = 1,
#       HOST_VALUE_UNEXPECTED_VAL_TYPE = 2,
#       HOST_VALUE_U63_OUT_OF_RANGE = 3,
#       HOST_VALUE_U32_OUT_OF_RANGE = 4,
#       HOST_VALUE_STATIC_UNKNOWN = 5,
#       HOST_VALUE_MISSING_OBJECT = 6,
#       HOST_VALUE_SYMBOL_TOO_LONG = 7,
#       HOST_VALUE_SYMBOL_BAD_CHAR = 8,
#       HOST_VALUE_SYMBOL_CONTAINS_NON_UTF8 = 9,
#       HOST_VALUE_BITSET_TOO_MANY_BITS = 10,
#       HOST_VALUE_STATUS_UNKNOWN = 11
#   };
#
# ===========================================================================
module Stellar
  class SCHostValErrorCode < XDR::Enum
    member :host_value_unknown_error,            0
    member :host_value_reserved_tag_value,       1
    member :host_value_unexpected_val_type,      2
    member :host_value_u63_out_of_range,         3
    member :host_value_u32_out_of_range,         4
    member :host_value_static_unknown,           5
    member :host_value_missing_object,           6
    member :host_value_symbol_too_long,          7
    member :host_value_symbol_bad_char,          8
    member :host_value_symbol_contains_non_utf8, 9
    member :host_value_bitset_too_many_bits,     10
    member :host_value_status_unknown,           11

    seal
  end
end

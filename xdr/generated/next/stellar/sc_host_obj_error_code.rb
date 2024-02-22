# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SCHostObjErrorCode
#   {
#       HOST_OBJECT_UNKNOWN_ERROR = 0,
#       HOST_OBJECT_UNKNOWN_REFERENCE = 1,
#       HOST_OBJECT_UNEXPECTED_TYPE = 2,
#       HOST_OBJECT_OBJECT_COUNT_EXCEEDS_U32_MAX = 3,
#       HOST_OBJECT_OBJECT_NOT_EXIST = 4,
#       HOST_OBJECT_VEC_INDEX_OUT_OF_BOUND = 5,
#       HOST_OBJECT_CONTRACT_HASH_WRONG_LENGTH = 6
#   };
#
# ===========================================================================
module Stellar
  class SCHostObjErrorCode < XDR::Enum
    member :host_object_unknown_error,                0
    member :host_object_unknown_reference,            1
    member :host_object_unexpected_type,              2
    member :host_object_object_count_exceeds_u32_max, 3
    member :host_object_object_not_exist,             4
    member :host_object_vec_index_out_of_bound,       5
    member :host_object_contract_hash_wrong_length,   6

    seal
  end
end

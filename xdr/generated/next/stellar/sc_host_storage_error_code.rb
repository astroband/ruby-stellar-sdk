# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SCHostStorageErrorCode
#   {
#       HOST_STORAGE_UNKNOWN_ERROR = 0,
#       HOST_STORAGE_EXPECT_CONTRACT_DATA = 1,
#       HOST_STORAGE_READWRITE_ACCESS_TO_READONLY_ENTRY = 2,
#       HOST_STORAGE_ACCESS_TO_UNKNOWN_ENTRY = 3,
#       HOST_STORAGE_MISSING_KEY_IN_GET = 4,
#       HOST_STORAGE_GET_ON_DELETED_KEY = 5
#   };
#
# ===========================================================================
module Stellar
  class SCHostStorageErrorCode < XDR::Enum
    member :host_storage_unknown_error,                      0
    member :host_storage_expect_contract_data,               1
    member :host_storage_readwrite_access_to_readonly_entry, 2
    member :host_storage_access_to_unknown_entry,            3
    member :host_storage_missing_key_in_get,                 4
    member :host_storage_get_on_deleted_key,                 5

    seal
  end
end

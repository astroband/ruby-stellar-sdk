# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SCStatusType
#   {
#       SST_OK = 0,
#       SST_UNKNOWN_ERROR = 1,
#       SST_HOST_VALUE_ERROR = 2,
#       SST_HOST_OBJECT_ERROR = 3,
#       SST_HOST_FUNCTION_ERROR = 4,
#       SST_HOST_STORAGE_ERROR = 5,
#       SST_HOST_CONTEXT_ERROR = 6,
#       SST_VM_ERROR = 7,
#       SST_CONTRACT_ERROR = 8,
#       SST_HOST_AUTH_ERROR = 9
#       // TODO: add more
#   };
#
# ===========================================================================
module Stellar
  class SCStatusType < XDR::Enum
    member :sst_ok,                  0
    member :sst_unknown_error,       1
    member :sst_host_value_error,    2
    member :sst_host_object_error,   3
    member :sst_host_function_error, 4
    member :sst_host_storage_error,  5
    member :sst_host_context_error,  6
    member :sst_vm_error,            7
    member :sst_contract_error,      8
    member :sst_host_auth_error,     9

    seal
  end
end

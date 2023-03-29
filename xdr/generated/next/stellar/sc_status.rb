# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union SCStatus switch (SCStatusType type)
#   {
#   case SST_OK:
#       void;
#   case SST_UNKNOWN_ERROR:
#       SCUnknownErrorCode unknownCode;
#   case SST_HOST_VALUE_ERROR:
#       SCHostValErrorCode valCode;
#   case SST_HOST_OBJECT_ERROR:
#       SCHostObjErrorCode objCode;
#   case SST_HOST_FUNCTION_ERROR:
#       SCHostFnErrorCode fnCode;
#   case SST_HOST_STORAGE_ERROR:
#       SCHostStorageErrorCode storageCode;
#   case SST_HOST_CONTEXT_ERROR:
#       SCHostContextErrorCode contextCode;
#   case SST_VM_ERROR:
#       SCVmErrorCode vmCode;
#   case SST_CONTRACT_ERROR:
#       uint32 contractCode;
#   case SST_HOST_AUTH_ERROR:
#       SCHostAuthErrorCode authCode;
#   };
#
# ===========================================================================
module Stellar
  class SCStatus < XDR::Union
    switch_on SCStatusType, :type

    switch :sst_ok
    switch :sst_unknown_error,       :unknown_code
    switch :sst_host_value_error,    :val_code
    switch :sst_host_object_error,   :obj_code
    switch :sst_host_function_error, :fn_code
    switch :sst_host_storage_error,  :storage_code
    switch :sst_host_context_error,  :context_code
    switch :sst_vm_error,            :vm_code
    switch :sst_contract_error,      :contract_code
    switch :sst_host_auth_error,     :auth_code

    attribute :unknown_code,  SCUnknownErrorCode
    attribute :val_code,      SCHostValErrorCode
    attribute :obj_code,      SCHostObjErrorCode
    attribute :fn_code,       SCHostFnErrorCode
    attribute :storage_code,  SCHostStorageErrorCode
    attribute :context_code,  SCHostContextErrorCode
    attribute :vm_code,       SCVmErrorCode
    attribute :contract_code, Uint32
    attribute :auth_code,     SCHostAuthErrorCode
  end
end

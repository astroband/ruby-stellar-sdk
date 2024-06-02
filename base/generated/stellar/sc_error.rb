# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union SCError switch (SCErrorType type)
#   {
#   case SCE_CONTRACT:
#       uint32 contractCode;
#   case SCE_WASM_VM:
#   case SCE_CONTEXT:
#   case SCE_STORAGE:
#   case SCE_OBJECT:
#   case SCE_CRYPTO:
#   case SCE_EVENTS:
#   case SCE_BUDGET:
#   case SCE_VALUE:
#   case SCE_AUTH:
#       SCErrorCode code;
#   };
#
# ===========================================================================
module Stellar
  class SCError < XDR::Union
    switch_on SCErrorType, :type

    switch :sce_contract, :contract_code
    switch :sce_wasm_vm,  :code
    switch :sce_context,  :code
    switch :sce_storage,  :code
    switch :sce_object,   :code
    switch :sce_crypto,   :code
    switch :sce_events,   :code
    switch :sce_budget,   :code
    switch :sce_value,    :code
    switch :sce_auth,     :code

    attribute :contract_code, Uint32
    attribute :code,          SCErrorCode
  end
end

# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SCErrorType
#   {
#       SCE_CONTRACT = 0,          // Contract-specific, user-defined codes.
#       SCE_WASM_VM = 1,           // Errors while interpreting WASM bytecode.
#       SCE_CONTEXT = 2,           // Errors in the contract's host context.
#       SCE_STORAGE = 3,           // Errors accessing host storage.
#       SCE_OBJECT = 4,            // Errors working with host objects.
#       SCE_CRYPTO = 5,            // Errors in cryptographic operations.
#       SCE_EVENTS = 6,            // Errors while emitting events.
#       SCE_BUDGET = 7,            // Errors relating to budget limits.
#       SCE_VALUE = 8,             // Errors working with host values or SCVals.
#       SCE_AUTH = 9               // Errors from the authentication subsystem.
#   };
#
# ===========================================================================
module Stellar
  class SCErrorType < XDR::Enum
    member :sce_contract, 0
    member :sce_wasm_vm,  1
    member :sce_context,  2
    member :sce_storage,  3
    member :sce_object,   4
    member :sce_crypto,   5
    member :sce_events,   6
    member :sce_budget,   7
    member :sce_value,    8
    member :sce_auth,     9

    seal
  end
end

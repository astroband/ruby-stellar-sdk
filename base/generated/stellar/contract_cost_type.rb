# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum ContractCostType {
#       // Cost of running 1 wasm instruction
#       WasmInsnExec = 0,
#       // Cost of growing wasm linear memory by 1 page
#       WasmMemAlloc = 1,
#       // Cost of allocating a chuck of host memory (in bytes)
#       HostMemAlloc = 2,
#       // Cost of copying a chuck of bytes into a pre-allocated host memory
#       HostMemCpy = 3,
#       // Cost of comparing two slices of host memory
#       HostMemCmp = 4,
#       // Cost of a host function dispatch, not including the actual work done by
#       // the function nor the cost of VM invocation machinary
#       DispatchHostFunction = 5,
#       // Cost of visiting a host object from the host object storage. Exists to
#       // make sure some baseline cost coverage, i.e. repeatly visiting objects
#       // by the guest will always incur some charges.
#       VisitObject = 6,
#       // Cost of serializing an xdr object to bytes
#       ValSer = 7,
#       // Cost of deserializing an xdr object from bytes
#       ValDeser = 8,
#       // Cost of computing the sha256 hash from bytes
#       ComputeSha256Hash = 9,
#       // Cost of computing the ed25519 pubkey from bytes
#       ComputeEd25519PubKey = 10,
#       // Cost of accessing an entry in a Map.
#       MapEntry = 11,
#       // Cost of accessing an entry in a Vec
#       VecEntry = 12,
#       // Cost of verifying ed25519 signature of a payload.
#       VerifyEd25519Sig = 13,
#       // Cost of reading a slice of vm linear memory
#       VmMemRead = 14,
#       // Cost of writing to a slice of vm linear memory
#       VmMemWrite = 15,
#       // Cost of instantiation a VM from wasm bytes code.
#       VmInstantiation = 16,
#       // Cost of instantiation a VM from a cached state.
#       VmCachedInstantiation = 17,
#       // Cost of invoking a function on the VM. If the function is a host function,
#       // additional cost will be covered by `DispatchHostFunction`.
#       InvokeVmFunction = 18,
#       // Cost of computing a keccak256 hash from bytes.
#       ComputeKeccak256Hash = 19,
#       // Cost of computing an ECDSA secp256k1 pubkey from bytes.
#       ComputeEcdsaSecp256k1Key = 20,
#       // Cost of computing an ECDSA secp256k1 signature from bytes.
#       ComputeEcdsaSecp256k1Sig = 21,
#       // Cost of recovering an ECDSA secp256k1 key from a signature.
#       RecoverEcdsaSecp256k1Key = 22,
#       // Cost of int256 addition (`+`) and subtraction (`-`) operations
#       Int256AddSub = 23,
#       // Cost of int256 multiplication (`*`) operation
#       Int256Mul = 24,
#       // Cost of int256 division (`/`) operation
#       Int256Div = 25,
#       // Cost of int256 power (`exp`) operation
#       Int256Pow = 26,
#       // Cost of int256 shift (`shl`, `shr`) operation
#       Int256Shift = 27
#   };
#
# ===========================================================================
module Stellar
  class ContractCostType < XDR::Enum
    member :wasm_insn_exec,              0
    member :wasm_mem_alloc,              1
    member :host_mem_alloc,              2
    member :host_mem_cpy,                3
    member :host_mem_cmp,                4
    member :dispatch_host_function,      5
    member :visit_object,                6
    member :val_ser,                     7
    member :val_deser,                   8
    member :compute_sha256_hash,         9
    member :compute_ed25519_pub_key,     10
    member :map_entry,                   11
    member :vec_entry,                   12
    member :verify_ed25519_sig,          13
    member :vm_mem_read,                 14
    member :vm_mem_write,                15
    member :vm_instantiation,            16
    member :vm_cached_instantiation,     17
    member :invoke_vm_function,          18
    member :compute_keccak256_hash,      19
    member :compute_ecdsa_secp256k1_key, 20
    member :compute_ecdsa_secp256k1_sig, 21
    member :recover_ecdsa_secp256k1_key, 22
    member :int256_add_sub,              23
    member :int256_mul,                  24
    member :int256_div,                  25
    member :int256_pow,                  26
    member :int256_shift,                27

    seal
  end
end

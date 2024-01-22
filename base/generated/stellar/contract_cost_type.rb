# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum ContractCostType {
#       // Cost of running 1 wasm instruction
#       WasmInsnExec = 0,
#       // Cost of allocating a slice of memory (in bytes)
#       MemAlloc = 1,
#       // Cost of copying a slice of bytes into a pre-allocated memory
#       MemCpy = 2,
#       // Cost of comparing two slices of memory
#       MemCmp = 3,
#       // Cost of a host function dispatch, not including the actual work done by
#       // the function nor the cost of VM invocation machinary
#       DispatchHostFunction = 4,
#       // Cost of visiting a host object from the host object storage. Exists to 
#       // make sure some baseline cost coverage, i.e. repeatly visiting objects
#       // by the guest will always incur some charges.
#       VisitObject = 5,
#       // Cost of serializing an xdr object to bytes
#       ValSer = 6,
#       // Cost of deserializing an xdr object from bytes
#       ValDeser = 7,
#       // Cost of computing the sha256 hash from bytes
#       ComputeSha256Hash = 8,
#       // Cost of computing the ed25519 pubkey from bytes
#       ComputeEd25519PubKey = 9,
#       // Cost of verifying ed25519 signature of a payload.
#       VerifyEd25519Sig = 10,
#       // Cost of instantiation a VM from wasm bytes code.
#       VmInstantiation = 11,
#       // Cost of instantiation a VM from a cached state.
#       VmCachedInstantiation = 12,
#       // Cost of invoking a function on the VM. If the function is a host function,
#       // additional cost will be covered by `DispatchHostFunction`.
#       InvokeVmFunction = 13,
#       // Cost of computing a keccak256 hash from bytes.
#       ComputeKeccak256Hash = 14,
#       // Cost of computing an ECDSA secp256k1 signature from bytes.
#       ComputeEcdsaSecp256k1Sig = 15,
#       // Cost of recovering an ECDSA secp256k1 key from a signature.
#       RecoverEcdsaSecp256k1Key = 16,
#       // Cost of int256 addition (`+`) and subtraction (`-`) operations
#       Int256AddSub = 17,
#       // Cost of int256 multiplication (`*`) operation
#       Int256Mul = 18,
#       // Cost of int256 division (`/`) operation
#       Int256Div = 19,
#       // Cost of int256 power (`exp`) operation
#       Int256Pow = 20,
#       // Cost of int256 shift (`shl`, `shr`) operation
#       Int256Shift = 21,
#       // Cost of drawing random bytes using a ChaCha20 PRNG
#       ChaCha20DrawBytes = 22
#   };
#
# ===========================================================================
module Stellar
  class ContractCostType < XDR::Enum
    member :wasm_insn_exec,              0
    member :mem_alloc,                   1
    member :mem_cpy,                     2
    member :mem_cmp,                     3
    member :dispatch_host_function,      4
    member :visit_object,                5
    member :val_ser,                     6
    member :val_deser,                   7
    member :compute_sha256_hash,         8
    member :compute_ed25519_pub_key,     9
    member :verify_ed25519_sig,          10
    member :vm_instantiation,            11
    member :vm_cached_instantiation,     12
    member :invoke_vm_function,          13
    member :compute_keccak256_hash,      14
    member :compute_ecdsa_secp256k1_sig, 15
    member :recover_ecdsa_secp256k1_key, 16
    member :int256_add_sub,              17
    member :int256_mul,                  18
    member :int256_div,                  19
    member :int256_pow,                  20
    member :int256_shift,                21
    member :cha_cha20_draw_bytes,        22

    seal
  end
end

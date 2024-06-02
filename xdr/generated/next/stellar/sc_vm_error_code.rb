# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SCVmErrorCode {
#       VM_UNKNOWN = 0,
#       VM_VALIDATION = 1,
#       VM_INSTANTIATION = 2,
#       VM_FUNCTION = 3,
#       VM_TABLE = 4,
#       VM_MEMORY = 5,
#       VM_GLOBAL = 6,
#       VM_VALUE = 7,
#       VM_TRAP_UNREACHABLE = 8,
#       VM_TRAP_MEMORY_ACCESS_OUT_OF_BOUNDS = 9,
#       VM_TRAP_TABLE_ACCESS_OUT_OF_BOUNDS = 10,
#       VM_TRAP_ELEM_UNINITIALIZED = 11,
#       VM_TRAP_DIVISION_BY_ZERO = 12,
#       VM_TRAP_INTEGER_OVERFLOW = 13,
#       VM_TRAP_INVALID_CONVERSION_TO_INT = 14,
#       VM_TRAP_STACK_OVERFLOW = 15,
#       VM_TRAP_UNEXPECTED_SIGNATURE = 16,
#       VM_TRAP_MEM_LIMIT_EXCEEDED = 17,
#       VM_TRAP_CPU_LIMIT_EXCEEDED = 18
#   };
#
# ===========================================================================
module Stellar
  class SCVmErrorCode < XDR::Enum
    member :vm_unknown,                          0
    member :vm_validation,                       1
    member :vm_instantiation,                    2
    member :vm_function,                         3
    member :vm_table,                            4
    member :vm_memory,                           5
    member :vm_global,                           6
    member :vm_value,                            7
    member :vm_trap_unreachable,                 8
    member :vm_trap_memory_access_out_of_bounds, 9
    member :vm_trap_table_access_out_of_bounds,  10
    member :vm_trap_elem_uninitialized,          11
    member :vm_trap_division_by_zero,            12
    member :vm_trap_integer_overflow,            13
    member :vm_trap_invalid_conversion_to_int,   14
    member :vm_trap_stack_overflow,              15
    member :vm_trap_unexpected_signature,        16
    member :vm_trap_mem_limit_exceeded,          17
    member :vm_trap_cpu_limit_exceeded,          18

    seal
  end
end

# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SCSpecEntryKind
#   {
#       SC_SPEC_ENTRY_FUNCTION_V0 = 0,
#       SC_SPEC_ENTRY_UDT_STRUCT_V0 = 1,
#       SC_SPEC_ENTRY_UDT_UNION_V0 = 2,
#       SC_SPEC_ENTRY_UDT_ENUM_V0 = 3,
#       SC_SPEC_ENTRY_UDT_ERROR_ENUM_V0 = 4
#   };
#
# ===========================================================================
module Stellar
  class SCSpecEntryKind < XDR::Enum
    member :sc_spec_entry_function_v0,       0
    member :sc_spec_entry_udt_struct_v0,     1
    member :sc_spec_entry_udt_union_v0,      2
    member :sc_spec_entry_udt_enum_v0,       3
    member :sc_spec_entry_udt_error_enum_v0, 4

    seal
  end
end

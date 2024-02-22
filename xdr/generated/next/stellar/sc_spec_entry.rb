# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union SCSpecEntry switch (SCSpecEntryKind kind)
#   {
#   case SC_SPEC_ENTRY_FUNCTION_V0:
#       SCSpecFunctionV0 functionV0;
#   case SC_SPEC_ENTRY_UDT_STRUCT_V0:
#       SCSpecUDTStructV0 udtStructV0;
#   case SC_SPEC_ENTRY_UDT_UNION_V0:
#       SCSpecUDTUnionV0 udtUnionV0;
#   case SC_SPEC_ENTRY_UDT_ENUM_V0:
#       SCSpecUDTEnumV0 udtEnumV0;
#   case SC_SPEC_ENTRY_UDT_ERROR_ENUM_V0:
#       SCSpecUDTErrorEnumV0 udtErrorEnumV0;
#   };
#
# ===========================================================================
module Stellar
  class SCSpecEntry < XDR::Union
    switch_on SCSpecEntryKind, :kind

    switch :sc_spec_entry_function_v0,       :function_v0
    switch :sc_spec_entry_udt_struct_v0,     :udt_struct_v0
    switch :sc_spec_entry_udt_union_v0,      :udt_union_v0
    switch :sc_spec_entry_udt_enum_v0,       :udt_enum_v0
    switch :sc_spec_entry_udt_error_enum_v0, :udt_error_enum_v0

    attribute :function_v0,       SCSpecFunctionV0
    attribute :udt_struct_v0,     SCSpecUDTStructV0
    attribute :udt_union_v0,      SCSpecUDTUnionV0
    attribute :udt_enum_v0,       SCSpecUDTEnumV0
    attribute :udt_error_enum_v0, SCSpecUDTErrorEnumV0
  end
end

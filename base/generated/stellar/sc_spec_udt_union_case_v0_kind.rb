# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SCSpecUDTUnionCaseV0Kind
#   {
#       SC_SPEC_UDT_UNION_CASE_VOID_V0 = 0,
#       SC_SPEC_UDT_UNION_CASE_TUPLE_V0 = 1
#   };
#
# ===========================================================================
module Stellar
  class SCSpecUDTUnionCaseV0Kind < XDR::Enum
    member :sc_spec_udt_union_case_void_v0,  0
    member :sc_spec_udt_union_case_tuple_v0, 1

    seal
  end
end

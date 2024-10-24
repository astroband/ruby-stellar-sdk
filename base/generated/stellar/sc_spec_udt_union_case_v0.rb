# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union SCSpecUDTUnionCaseV0 switch (SCSpecUDTUnionCaseV0Kind kind)
#   {
#   case SC_SPEC_UDT_UNION_CASE_VOID_V0:
#       SCSpecUDTUnionCaseVoidV0 voidCase;
#   case SC_SPEC_UDT_UNION_CASE_TUPLE_V0:
#       SCSpecUDTUnionCaseTupleV0 tupleCase;
#   };
#
# ===========================================================================
module Stellar
  class SCSpecUDTUnionCaseV0 < XDR::Union
    switch_on SCSpecUDTUnionCaseV0Kind, :kind

    switch :sc_spec_udt_union_case_void_v0,  :void_case
    switch :sc_spec_udt_union_case_tuple_v0, :tuple_case

    attribute :void_case,  SCSpecUDTUnionCaseVoidV0
    attribute :tuple_case, SCSpecUDTUnionCaseTupleV0
  end
end

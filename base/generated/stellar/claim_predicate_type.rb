# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum ClaimPredicateType
#   {
#       CLAIM_PREDICATE_UNCONDITIONAL = 0,
#       CLAIM_PREDICATE_AND = 1,
#       CLAIM_PREDICATE_OR = 2,
#       CLAIM_PREDICATE_NOT = 3,
#       CLAIM_PREDICATE_BEFORE_ABSOLUTE_TIME = 4,
#       CLAIM_PREDICATE_BEFORE_RELATIVE_TIME = 5
#   };
#
# ===========================================================================
module Stellar
  class ClaimPredicateType < XDR::Enum
    member :claim_predicate_unconditional,        0
    member :claim_predicate_and,                  1
    member :claim_predicate_or,                   2
    member :claim_predicate_not,                  3
    member :claim_predicate_before_absolute_time, 4
    member :claim_predicate_before_relative_time, 5

    seal
  end
end

# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union ClaimPredicate switch (ClaimPredicateType type)
#   {
#   case CLAIM_PREDICATE_UNCONDITIONAL:
#       void;
#   case CLAIM_PREDICATE_AND:
#       ClaimPredicate andPredicates<2>;
#   case CLAIM_PREDICATE_OR:
#       ClaimPredicate orPredicates<2>;
#   case CLAIM_PREDICATE_NOT:
#       ClaimPredicate* notPredicate;
#   case CLAIM_PREDICATE_BEFORE_ABSOLUTE_TIME:
#       int64 absBefore; // Predicate will be true if closeTime < absBefore
#   case CLAIM_PREDICATE_BEFORE_RELATIVE_TIME:
#       int64 relBefore; // Seconds since closeTime of the ledger in which the
#                        // ClaimableBalanceEntry was created
#   };
#
# ===========================================================================
module Stellar
  class ClaimPredicate < XDR::Union
    switch_on ClaimPredicateType, :type

    switch :claim_predicate_unconditional
    switch :claim_predicate_and,                  :and_predicates
    switch :claim_predicate_or,                   :or_predicates
    switch :claim_predicate_not,                  :not_predicate
    switch :claim_predicate_before_absolute_time, :abs_before
    switch :claim_predicate_before_relative_time, :rel_before

    attribute :and_predicates, XDR::VarArray[ClaimPredicate, 2]
    attribute :or_predicates,  XDR::VarArray[ClaimPredicate, 2]
    attribute :not_predicate,  XDR::Option[ClaimPredicate]
    attribute :abs_before,     Int64
    attribute :rel_before,     Int64
  end
end

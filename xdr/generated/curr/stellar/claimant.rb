# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union Claimant switch (ClaimantType type)
#   {
#   case CLAIMANT_TYPE_V0:
#       struct
#       {
#           AccountID destination;    // The account that can use this condition
#           ClaimPredicate predicate; // Claimable if predicate is true
#       } v0;
#   };
#
# ===========================================================================
module Stellar
  class Claimant < XDR::Union
    include XDR::Namespace

    autoload :V0

    switch_on ClaimantType, :type

    switch :claimant_type_v0, :v0

    attribute :v0, V0
  end
end

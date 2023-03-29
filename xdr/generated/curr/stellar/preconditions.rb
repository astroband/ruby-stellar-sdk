# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union Preconditions switch (PreconditionType type)
#   {
#   case PRECOND_NONE:
#       void;
#   case PRECOND_TIME:
#       TimeBounds timeBounds;
#   case PRECOND_V2:
#       PreconditionsV2 v2;
#   };
#
# ===========================================================================
module Stellar
  class Preconditions < XDR::Union
    switch_on PreconditionType, :type

    switch :precond_none
    switch :precond_time, :time_bounds
    switch :precond_v2,   :v2

    attribute :time_bounds, TimeBounds
    attribute :v2,          PreconditionsV2
  end
end

# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union PersistedSCPState switch (int v)
#   {
#   case 0:
#     PersistedSCPStateV0 v0;
#   case 1:
#     PersistedSCPStateV1 v1;
#   };
#
# ===========================================================================
module Stellar
  class PersistedSCPState < XDR::Union
    switch_on XDR::Int, :v

    switch 0, :v0
    switch 1, :v1

    attribute :v0, PersistedSCPStateV0
    attribute :v1, PersistedSCPStateV1
  end
end

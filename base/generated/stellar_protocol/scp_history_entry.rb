# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union SCPHistoryEntry switch (int v)
#   {
#   case 0:
#       SCPHistoryEntryV0 v0;
#   };
#
# ===========================================================================
module StellarProtocol
  class SCPHistoryEntry < XDR::Union
    switch_on XDR::Int, :v

    switch 0, :v0

    attribute :v0, SCPHistoryEntryV0
  end
end

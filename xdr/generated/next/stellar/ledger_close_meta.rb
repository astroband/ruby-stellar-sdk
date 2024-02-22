# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union LedgerCloseMeta switch (int v)
#   {
#   case 0:
#       LedgerCloseMetaV0 v0;
#   case 1:
#       LedgerCloseMetaV1 v1;
#   case 2:
#       LedgerCloseMetaV2 v2;
#   };
#
# ===========================================================================
module Stellar
  class LedgerCloseMeta < XDR::Union
    switch_on XDR::Int, :v

    switch 0, :v0
    switch 1, :v1
    switch 2, :v2

    attribute :v0, LedgerCloseMetaV0
    attribute :v1, LedgerCloseMetaV1
    attribute :v2, LedgerCloseMetaV2
  end
end

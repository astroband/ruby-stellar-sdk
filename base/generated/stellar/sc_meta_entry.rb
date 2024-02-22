# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union SCMetaEntry switch (SCMetaKind kind)
#   {
#   case SC_META_V0:
#       SCMetaV0 v0;
#   };
#
# ===========================================================================
module Stellar
  class SCMetaEntry < XDR::Union
    switch_on SCMetaKind, :kind

    switch :sc_meta_v0, :v0

    attribute :v0, SCMetaV0
  end
end

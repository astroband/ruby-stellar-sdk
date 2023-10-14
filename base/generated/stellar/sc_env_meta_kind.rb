# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SCEnvMetaKind
#   {
#       SC_ENV_META_KIND_INTERFACE_VERSION = 0
#   };
#
# ===========================================================================
module Stellar
  class SCEnvMetaKind < XDR::Enum
    member :sc_env_meta_kind_interface_version, 0

    seal
  end
end

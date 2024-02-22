# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union SCEnvMetaEntry switch (SCEnvMetaKind kind)
#   {
#   case SC_ENV_META_KIND_INTERFACE_VERSION:
#       uint64 interfaceVersion;
#   };
#
# ===========================================================================
module Stellar
  class SCEnvMetaEntry < XDR::Union
    switch_on SCEnvMetaKind, :kind

    switch :sc_env_meta_kind_interface_version, :interface_version

    attribute :interface_version, Uint64
  end
end

# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct ConfigUpgradeSetKey {
#       Hash contractID;
#       Hash contentHash;
#   };
#
# ===========================================================================
module Stellar
  class ConfigUpgradeSetKey < XDR::Struct
    attribute :contract_id,  Hash
    attribute :content_hash, Hash
  end
end

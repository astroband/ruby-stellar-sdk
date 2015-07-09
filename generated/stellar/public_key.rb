# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union PublicKey switch (CryptoKeyType type)
#   {
#   case KEY_TYPES_ED25519:
#       uint256 ed25519;
#   };
#
# ===========================================================================
module Stellar
  class PublicKey < XDR::Union
    switch_on CryptoKeyType, :type

    switch :key_types_ed25519, :ed25519

    attribute :ed25519, Uint256
  end
end

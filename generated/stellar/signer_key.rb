# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union SignerKey switch (SignerKeyType type)
#   {
#   case SIGNER_KEY_TYPE_ED25519:
#       uint256 ed25519;
#   case SIGNER_KEY_TYPE_HASH_TX:
#       Hash hashTx;
#   case SIGNER_KEY_TYPE_HASH_X:
#       Hash hashX;
#   };
#
# ===========================================================================
module Stellar
  class SignerKey < XDR::Union
    switch_on SignerKeyType, :type

    switch :signer_key_type_ed25519, :ed25519
    switch :signer_key_type_hash_tx, :hash_tx
    switch :signer_key_type_hash_x,  :hash_x

    attribute :ed25519, Uint256
    attribute :hash_tx, Hash
    attribute :hash_x,  Hash
  end
end

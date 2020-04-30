# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union SignerKey switch (SignerKeyType type)
#   {
#   case SIGNER_KEY_TYPE_ED25519:
#       uint256 ed25519;
#   case SIGNER_KEY_TYPE_PRE_AUTH_TX:
#       /* SHA-256 Hash of TransactionSignaturePayload structure */
#       uint256 preAuthTx;
#   case SIGNER_KEY_TYPE_HASH_X:
#       /* Hash of random 256 bit preimage X */
#       uint256 hashX;
#   };
#
# ===========================================================================
module Stellar
  class SignerKey < XDR::Union
    switch_on SignerKeyType, :type

    switch :signer_key_type_ed25519,     :ed25519
    switch :signer_key_type_pre_auth_tx, :pre_auth_tx
    switch :signer_key_type_hash_x,      :hash_x

    attribute :ed25519,     Uint256
    attribute :pre_auth_tx, Uint256
    attribute :hash_x,      Uint256
  end
end

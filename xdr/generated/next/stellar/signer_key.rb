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
#   case SIGNER_KEY_TYPE_ED25519_SIGNED_PAYLOAD:
#       struct
#       {
#           /* Public key that must sign the payload. */
#           uint256 ed25519;
#           /* Payload to be raw signed by ed25519. */
#           opaque payload<64>;
#       } ed25519SignedPayload;
#   };
#
# ===========================================================================
module Stellar
  class SignerKey < XDR::Union
    include XDR::Namespace

    autoload :Ed25519SignedPayload

    switch_on SignerKeyType, :type

    switch :signer_key_type_ed25519,                :ed25519
    switch :signer_key_type_pre_auth_tx,            :pre_auth_tx
    switch :signer_key_type_hash_x,                 :hash_x
    switch :signer_key_type_ed25519_signed_payload, :ed25519_signed_payload

    attribute :ed25519,                Uint256
    attribute :pre_auth_tx,            Uint256
    attribute :hash_x,                 Uint256
    attribute :ed25519_signed_payload, Ed25519SignedPayload
  end
end

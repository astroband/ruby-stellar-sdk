# Automatically generated on 2015-03-31T14:32:44-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct DecoratedSignature
#   {
#       opaque hint[4];    // first 4 bytes of the public key, used as a hint
#       uint512 signature; // actual signature
#   };
#
# ===========================================================================
module Stellar
  class DecoratedSignature < XDR::Struct
    attribute :hint,      XDR::Opaque[4]
    attribute :signature, Uint512
  end
end

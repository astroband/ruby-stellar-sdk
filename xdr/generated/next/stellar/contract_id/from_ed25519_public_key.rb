# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct 
#       {
#           uint256 key;
#           Signature signature;
#           uint256 salt;
#       }
#
# ===========================================================================
module Stellar
  class ContractID
    class FromEd25519PublicKey < XDR::Struct
      attribute :key,       Uint256
      attribute :signature, Signature
      attribute :salt,      Uint256
    end
  end
end

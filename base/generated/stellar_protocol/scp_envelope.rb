# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SCPEnvelope
#   {
#       SCPStatement statement;
#       Signature signature;
#   };
#
# ===========================================================================
module StellarProtocol
  class SCPEnvelope < XDR::Struct
    attribute :statement, SCPStatement
    attribute :signature, Signature
  end
end

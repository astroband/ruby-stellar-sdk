# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SignedSurveyResponseMessage
#   {
#       Signature responseSignature;
#       SurveyResponseMessage response;
#   };
#
# ===========================================================================
module StellarProtocol
  class SignedSurveyResponseMessage < XDR::Struct
    attribute :response_signature, Signature
    attribute :response,           SurveyResponseMessage
  end
end

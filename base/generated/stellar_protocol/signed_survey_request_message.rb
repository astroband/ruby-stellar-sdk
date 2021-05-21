# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SignedSurveyRequestMessage
#   {
#       Signature requestSignature;
#       SurveyRequestMessage request;
#   };
#
# ===========================================================================
module StellarProtocol
  class SignedSurveyRequestMessage < XDR::Struct
    attribute :request_signature, Signature
    attribute :request,           SurveyRequestMessage
  end
end

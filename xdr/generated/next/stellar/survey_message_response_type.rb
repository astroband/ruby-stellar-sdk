# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SurveyMessageResponseType
#   {
#       SURVEY_TOPOLOGY_RESPONSE_V0 = 0,
#       SURVEY_TOPOLOGY_RESPONSE_V1 = 1
#   };
#
# ===========================================================================
module Stellar
  class SurveyMessageResponseType < XDR::Enum
    member :survey_topology_response_v0, 0
    member :survey_topology_response_v1, 1

    seal
  end
end

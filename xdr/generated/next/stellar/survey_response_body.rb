# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union SurveyResponseBody switch (SurveyMessageResponseType type)
#   {
#   case SURVEY_TOPOLOGY_RESPONSE_V0:
#       TopologyResponseBodyV0 topologyResponseBodyV0;
#   case SURVEY_TOPOLOGY_RESPONSE_V1:
#       TopologyResponseBodyV1 topologyResponseBodyV1;
#   };
#
# ===========================================================================
module Stellar
  class SurveyResponseBody < XDR::Union
    switch_on SurveyMessageResponseType, :type

    switch :survey_topology_response_v0, :topology_response_body_v0
    switch :survey_topology_response_v1, :topology_response_body_v1

    attribute :topology_response_body_v0, TopologyResponseBodyV0
    attribute :topology_response_body_v1, TopologyResponseBodyV1
  end
end

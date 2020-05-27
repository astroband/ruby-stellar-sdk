# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union SurveyResponseBody switch (SurveyMessageCommandType type)
#   {
#   case SURVEY_TOPOLOGY:
#       TopologyResponseBody topologyResponseBody;
#   };
#
# ===========================================================================
module Stellar
  class SurveyResponseBody < XDR::Union
    switch_on SurveyMessageCommandType, :type

    switch :survey_topology, :topology_response_body

    attribute :topology_response_body, TopologyResponseBody
  end
end

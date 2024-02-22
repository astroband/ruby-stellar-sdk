# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SurveyMessageCommandType
#   {
#       SURVEY_TOPOLOGY = 0
#   };
#
# ===========================================================================
module Stellar
  class SurveyMessageCommandType < XDR::Enum
    member :survey_topology, 0

    seal
  end
end

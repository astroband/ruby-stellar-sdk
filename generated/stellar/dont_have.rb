# Automatically generated on 2015-05-12T09:08:23-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct DontHave
#   {
#       MessageType type;
#       uint256 reqHash;
#   };
#
# ===========================================================================
module Stellar
  class DontHave < XDR::Struct
    attribute :type,     MessageType
    attribute :req_hash, Uint256
  end
end

# Automatically generated on 2015-04-26T19:13:29-07:00
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

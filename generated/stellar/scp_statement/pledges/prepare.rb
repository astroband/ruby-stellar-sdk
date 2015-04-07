# Automatically generated on 2015-04-07T10:52:07-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct
#           {
#               SCPBallot excepted<>; // B_c
#               SCPBallot* prepared;  // p
#           }
#
# ===========================================================================
module Stellar
  class SCPStatement
    class Pledges
      class Prepare < XDR::Struct
        attribute :excepted, XDR::VarArray[SCPBallot]
        attribute :prepared, XDR::Option[SCPBallot]
      end
    end
  end
end

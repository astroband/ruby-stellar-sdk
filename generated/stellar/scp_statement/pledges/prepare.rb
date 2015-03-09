# Automatically generated from xdr/SCPXDR.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

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

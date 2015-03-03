# Automatically generated from xdr/FBAXDR.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class FBAStatement
    class Pledges
      class Prepare < XDR::Struct
        attribute :excepted, XDR::VarArray[FBABallot]
        attribute :prepared, XDR::Option[FBABallot]
      end
    end
  end
end

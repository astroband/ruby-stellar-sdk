# Automatically generated on 2015-03-30T09:46:31-07:00
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

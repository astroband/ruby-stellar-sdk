# Automatically generated from xdr/SCPXDR.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class SCPStatementType < XDR::Enum
    member :prepare,   0
    member :prepared,  1
    member :commit,    2
    member :committed, 3

    seal
  end
end

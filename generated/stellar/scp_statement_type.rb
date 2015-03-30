# Automatically generated on 2015-03-30T09:46:31-07:00
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

# Automatically generated from xdr/SCPXDR.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class SCPStatement
    class Pledges < XDR::Union
      include XDR::Namespace

      autoload :Prepare

      switch_on SCPStatementType, :type
                       
      switch :prepare, :prepare
                             switch :prepared
                             switch :commit
                             switch :committed
                          
      attribute :prepare, Prepare
    end
  end
end

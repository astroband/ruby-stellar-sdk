# Automatically generated on 2015-03-30T09:46:31-07:00
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

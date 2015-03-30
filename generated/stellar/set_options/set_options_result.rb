# Automatically generated on 2015-03-30T09:46:32-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  module SetOptions
    class SetOptionsResult < XDR::Union
      switch_on SetOptionsResultCode, :code

      switch :success
      switch :default

    end
  end
end

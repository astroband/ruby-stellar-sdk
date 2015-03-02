# Automatically generated from xdr/Stellar-transaction.x
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

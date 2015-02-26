# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  module SetOption
    class SetOptionsResult < XDR::Union


      switch_on SetOptionsResultCode, :code

      switch SetOptionsResultCode.success
      switch :default

    end
  end
end

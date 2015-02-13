# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  module SetOption
    class SetOptionsResult
      class Result < XDR::Union


        switch_on SetOptionsResultCode, :code

        switch SetOptionsResultCode.success
        switch :default

      end
    end
  end
end

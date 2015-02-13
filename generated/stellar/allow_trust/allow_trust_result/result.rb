# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  module AllowTrust
    class AllowTrustResult
      class Result < XDR::Union


        switch_on AllowTrustResultCode, :code

        switch AllowTrustResultCode.success
        switch :default

      end
    end
  end
end

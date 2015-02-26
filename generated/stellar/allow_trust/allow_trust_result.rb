# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  module AllowTrust
    class AllowTrustResult < XDR::Union


      switch_on AllowTrustResultCode, :code

      switch AllowTrustResultCode.success
      switch :default

    end
  end
end

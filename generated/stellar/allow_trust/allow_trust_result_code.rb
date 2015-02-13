# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  module AllowTrust
    class AllowTrustResultCode < XDR::Enum
      member :success,       0
      member :malformed,     1
      member :no_trust_line, 2

      seal
    end
  end
end

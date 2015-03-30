# Automatically generated on 2015-03-30T09:46:32-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

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

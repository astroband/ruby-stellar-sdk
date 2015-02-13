# Automatically generated from xdr/Stellar-ledger.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  class CLFType < XDR::Enum
    member :liveentry, 0
    member :deadentry, 1

    seal
  end
end

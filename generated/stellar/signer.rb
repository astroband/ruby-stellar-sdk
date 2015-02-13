# Automatically generated from xdr/Stellar-ledger-entries.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  class Signer < XDR::Struct

                        
    attribute :pub_key, Uint256
    attribute :weight,  Uint32
  end
end

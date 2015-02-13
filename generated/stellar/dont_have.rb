# Automatically generated from xdr/Stellar-overlay.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  class DontHave < XDR::Struct

                         
    attribute :type,     MessageType
    attribute :req_hash, Uint256
  end
end

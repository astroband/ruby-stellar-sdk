# Automatically generated on 2015-03-30T09:46:31-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class DontHave < XDR::Struct
    attribute :type,     MessageType
    attribute :req_hash, Uint256
  end
end

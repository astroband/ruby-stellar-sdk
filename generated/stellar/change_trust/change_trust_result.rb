# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  module ChangeTrust
    class ChangeTrustResult < XDR::Struct
      autoload :Result, "#{File.dirname(__FILE__)}/change_trust_result/result"
                         
      attribute :result, Result
    end
  end
end

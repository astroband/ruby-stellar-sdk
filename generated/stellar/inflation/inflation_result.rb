# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  module Inflation
    class InflationResult < XDR::Struct
      autoload :Result, "#{File.dirname(__FILE__)}/inflation_result/result"
                         
      attribute :result, Result
    end
  end
end

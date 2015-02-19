# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  module SetOption
    class SetOptionsResult < XDR::Struct
      autoload :Result, "#{File.dirname(__FILE__)}/set_options_result/result"
                         
      attribute :result, Result
    end
  end
end

# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  module AccountMerge
    class AccountMergeResult < XDR::Struct
      autoload :Result, "#{File.dirname(__FILE__)}/account_merge_result/result"
                         
      attribute :result, Result
    end
  end
end

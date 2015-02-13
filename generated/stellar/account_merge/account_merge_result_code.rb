# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  module AccountMerge
    class AccountMergeResultCode < XDR::Enum
      member :success,    0
      member :malformed,  1
      member :no_account, 2
      member :has_credit, 3

      seal
    end
  end
end

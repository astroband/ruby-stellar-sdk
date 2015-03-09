# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class Operation < XDR::Struct
    include XDR::Namespace

    autoload :Body
                               
    attribute :source_account, XDR::Option[AccountID]
    attribute :body,           Body
  end
end

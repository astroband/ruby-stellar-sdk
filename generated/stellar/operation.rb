# Automatically generated on 2015-03-30T09:46:31-07:00
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

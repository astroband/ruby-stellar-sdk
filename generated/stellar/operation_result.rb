# Automatically generated on 2015-03-30T09:46:31-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class OperationResult < XDR::Union
    include XDR::Namespace

    autoload :Tr

    switch_on OperationResultCode, :code

    switch :op_inner, :tr
    switch :default

    attribute :tr, Tr
  end
end

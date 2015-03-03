# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class TransactionResult
    class Body < XDR::Union
      include XDR::Namespace

      autoload :Tr

      switch_on TransactionResultCode, :code
                        
      switch :tx_inner, :tr
                              switch :default
                     
      attribute :tr, Tr
    end
  end
end

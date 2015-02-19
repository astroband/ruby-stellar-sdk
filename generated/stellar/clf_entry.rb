# Automatically generated from xdr/Stellar-ledger.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  class CLFEntry < XDR::Struct
    autoload :Entry, "#{File.dirname(__FILE__)}/clf_entry/entry"
                      
    attribute :hash,  Hash
    attribute :entry, Entry
  end
end

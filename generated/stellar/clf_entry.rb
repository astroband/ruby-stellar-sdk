# Automatically generated from xdr/Stellar-ledger.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  class CLFEntry < XDR::Struct
    autoload :Entry, "#{__dir__}/clf_entry/entry"
                      
    attribute :hash,  Hash
    attribute :entry, Entry
  end
end

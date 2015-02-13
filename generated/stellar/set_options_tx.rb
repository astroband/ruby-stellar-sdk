# Automatically generated from xdr/Stellar-transaction.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  class SetOptionsTx < XDR::Struct

                               
    attribute :inflation_dest, XDR::Option[AccountID]
    attribute :clear_flags,    XDR::Option[Uint32]
    attribute :set_flags,      XDR::Option[Uint32]
    attribute :data,           XDR::Option[KeyValue]
    attribute :thresholds,     XDR::Option[Threshold]
    attribute :signer,         XDR::Option[Signer]
  end
end

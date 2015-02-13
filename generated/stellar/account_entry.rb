# Automatically generated from xdr/Stellar-ledger-entries.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  class AccountEntry < XDR::Struct

                               
    attribute :account_id,     Uint256
    attribute :balance,        Int64
    attribute :sequence,       Uint32
    attribute :owner_count,    Uint32
    attribute :inflation_dest, XDR::Option[Uint256]
    attribute :thresholds,     XDR::Opaque[4]
    attribute :signers,        XDR::VarArray[Signer]
    attribute :data,           XDR::VarArray[KeyValue]
    attribute :flags,          Uint32
  end
end

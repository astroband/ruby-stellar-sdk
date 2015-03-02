# Automatically generated from xdr/Stellar-ledger-entries.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class AccountEntry < XDR::Struct

                                
    attribute :account_id,      Uint256
    attribute :balance,         Int64
    attribute :num_sub_entries, Uint32
    attribute :inflation_dest,  XDR::Option[Uint256]
    attribute :thresholds,      XDR::Opaque[4]
    attribute :signers,         XDR::VarArray[Signer]
    attribute :seq_slots,       XDR::VarArray[Uint32]
    attribute :data,            XDR::VarArray[KeyValue]
    attribute :flags,           Uint32
  end
end

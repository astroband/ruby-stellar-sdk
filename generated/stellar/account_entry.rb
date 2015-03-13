# Automatically generated from xdr/Stellar-ledger-entries.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class AccountEntry < XDR::Struct
    attribute :account_id,      Uint256
    attribute :balance,         Int64
    attribute :seq_num,         SequenceNumber
    attribute :num_sub_entries, Uint32
    attribute :inflation_dest,  XDR::Option[Uint256]
    attribute :thresholds,      XDR::Opaque[4]
    attribute :signers,         XDR::VarArray[Signer, 20]
    attribute :data,            XDR::VarArray[KeyValue]
    attribute :flags,           Uint32
  end
end

# Automatically generated on 2015-03-30T09:46:31-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class SetOptionsOp < XDR::Struct
    attribute :inflation_dest, XDR::Option[AccountID]
    attribute :clear_flags,    XDR::Option[Uint32]
    attribute :set_flags,      XDR::Option[Uint32]
    attribute :data,           XDR::Option[KeyValue]
    attribute :thresholds,     XDR::Option[Thresholds]
    attribute :signer,         XDR::Option[Signer]
  end
end

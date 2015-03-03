# Automatically generated from xdr/Stellar-types.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  include XDR::Namespace

  Uint512 = XDR::Opaque[64]
  Uint256 = XDR::Opaque[32]
  Uint64 = XDR::UnsignedHyper
  Int64 = XDR::Hyper
  Uint32 = XDR::UnsignedInt
  Int32 = XDR::Int
  AccountID = XDR::Opaque[32]
  Signature = XDR::Opaque[64]
  Hash = XDR::Opaque[32]
  Thresholds = XDR::Opaque[4]

  autoload :CurrencyType

  autoload :ISOCurrencyIssuer

  autoload :Currency

  autoload :Price
end

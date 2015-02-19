# Automatically generated from xdr/Stellar-types.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'

module Stellar
  Uint512 = XDR::Opaque[64]
  Uint256 = XDR::Opaque[32]
  Uint64 = XDR::UnsignedHyper
  Int64 = XDR::Hyper
  Uint32 = XDR::UnsignedInt
  Int32 = XDR::Int
  AccountID = XDR::Opaque[32]
  Signature = XDR::Opaque[64]
  Hash = XDR::Opaque[32]
  Threshold = XDR::Opaque[4]

  autoload :CurrencyType, "#{File.dirname(__FILE__)}/stellar/currency_type"

  autoload :ISOCurrencyIssuer, "#{File.dirname(__FILE__)}/stellar/iso_currency_issuer"

  autoload :Currency, "#{File.dirname(__FILE__)}/stellar/currency"

  autoload :Price, "#{File.dirname(__FILE__)}/stellar/price"
end

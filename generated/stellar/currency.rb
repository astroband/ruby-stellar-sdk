# Automatically generated on 2015-05-12T09:08:23-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   union Currency switch (CurrencyType type)
#   {
#   case CURRENCY_TYPE_NATIVE:
#       void;
#   
#   case CURRENCY_TYPE_ALPHANUM:
#       struct
#       {
#           opaque currencyCode[4];
#           AccountID issuer;
#       } alphaNum;
#   
#       // add other currency types here in the future
#   };
#
# ===========================================================================
module Stellar
  class Currency < XDR::Union
    include XDR::Namespace

    autoload :AlphaNum

    switch_on CurrencyType, :type

    switch :currency_type_native
    switch :currency_type_alphanum, :alpha_num

    attribute :alpha_num, AlphaNum
  end
end

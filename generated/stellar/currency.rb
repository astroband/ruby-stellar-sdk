# Automatically generated on 2015-04-26T19:13:29-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   union Currency switch (CurrencyType type)
#   {
#   case NATIVE:
#       void;
#   
#   case ISO4217:
#       ISOCurrencyIssuer isoCI;
#   
#       // add other currency types here in the future
#   };
#
# ===========================================================================
module Stellar
  class Currency < XDR::Union
    switch_on CurrencyType, :type

    switch :native
    switch :iso4217, :iso_ci

    attribute :iso_ci, ISOCurrencyIssuer
  end
end

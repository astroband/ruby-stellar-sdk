# Automatically generated on 2015-04-26T19:13:29-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct Error
#   {
#       int code;
#       string msg<100>;
#   };
#
# ===========================================================================
module Stellar
  class Error < XDR::Struct
    attribute :code, XDR::Int
    attribute :msg,  XDR::String[100]
  end
end

# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct Error
#   {
#       ErrorCode code;
#       string msg<100>;
#   };
#
# ===========================================================================
module StellarProtocol
  class Error < XDR::Struct
    attribute :code, ErrorCode
    attribute :msg,  XDR::String[100]
  end
end

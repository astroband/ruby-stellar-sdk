# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union AuthenticatedMessage switch (uint32 v)
#   {
#   case 0:
#       struct
#       {
#           uint64 sequence;
#           StellarMessage message;
#           HmacSha256Mac mac;
#       } v0;
#   };
#
# ===========================================================================
module StellarProtocol
  class AuthenticatedMessage < XDR::Union
    include XDR::Namespace

    autoload :V0

    switch_on Uint32, :v

    switch 0, :v0

    attribute :v0, V0
  end
end

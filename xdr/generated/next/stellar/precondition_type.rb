# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum PreconditionType
#   {
#       PRECOND_NONE = 0,
#       PRECOND_TIME = 1,
#       PRECOND_V2 = 2
#   };
#
# ===========================================================================
module Stellar
  class PreconditionType < XDR::Enum
    member :precond_none, 0
    member :precond_time, 1
    member :precond_v2,   2

    seal
  end
end

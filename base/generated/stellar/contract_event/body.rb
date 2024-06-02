# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union switch (int v)
#       {
#       case 0:
#           struct
#           {
#               SCVal topics<>;
#               SCVal data;
#           } v0;
#       }
#
# ===========================================================================
module Stellar
  class ContractEvent
    class Body < XDR::Union
      include XDR::Namespace

      autoload :V0

      switch_on XDR::Int, :v

      switch 0, :v0

      attribute :v0, V0
    end
  end
end

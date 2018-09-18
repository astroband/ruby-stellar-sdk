# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union switch (int v)
#       {
#       case 0:
#           void;
#       case 1:
#           struct
#           {
#               Liabilities liabilities;
#   
#               union switch (int v)
#               {
#               case 0:
#                   void;
#               }
#               ext;
#           } v1;
#       }
#
# ===========================================================================
module Stellar
  class TrustLineEntry
    class Ext < XDR::Union
      include XDR::Namespace

      autoload :V1

      switch_on XDR::Int, :v

      switch 0
      switch 1, :v1

      attribute :v1, V1
    end
  end
end

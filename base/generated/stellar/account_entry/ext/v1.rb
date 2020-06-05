# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#           {
#               Liabilities liabilities;
#   
#               union switch (int v)
#               {
#               case 0:
#                   void;
#               }
#               ext;
#           }
#
# ===========================================================================
module Stellar
  class AccountEntry
    class Ext
      class V1 < XDR::Struct
        include XDR::Namespace

        autoload :Ext

        attribute :liabilities, Liabilities
        attribute :ext,         Ext
      end
    end
  end
end

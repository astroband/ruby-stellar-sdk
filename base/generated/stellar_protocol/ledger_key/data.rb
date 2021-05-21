# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           AccountID accountID;
#           string64 dataName;
#       }
#
# ===========================================================================
module StellarProtocol
  class LedgerKey
    class Data < XDR::Struct
      attribute :account_id, AccountID
      attribute :data_name,  String64
    end
  end
end

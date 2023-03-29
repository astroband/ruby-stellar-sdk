# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           AccountID accountID;
#           SignerKey signerKey;
#       }
#
# ===========================================================================
module Stellar
  class RevokeSponsorshipOp
    class Signer < XDR::Struct
      attribute :account_id, AccountID
      attribute :signer_key, SignerKey
    end
  end
end

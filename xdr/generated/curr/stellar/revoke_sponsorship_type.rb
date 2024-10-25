# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum RevokeSponsorshipType
#   {
#       REVOKE_SPONSORSHIP_LEDGER_ENTRY = 0,
#       REVOKE_SPONSORSHIP_SIGNER = 1
#   };
#
# ===========================================================================
module Stellar
  class RevokeSponsorshipType < XDR::Enum
    member :revoke_sponsorship_ledger_entry, 0
    member :revoke_sponsorship_signer,       1

    seal
  end
end

# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union RevokeSponsorshipOp switch (RevokeSponsorshipType type)
#   {
#   case REVOKE_SPONSORSHIP_LEDGER_ENTRY:
#       LedgerKey ledgerKey;
#   case REVOKE_SPONSORSHIP_SIGNER:
#       struct
#       {
#           AccountID accountID;
#           SignerKey signerKey;
#       }
#       signer;
#   };
#
# ===========================================================================
module Stellar
  class RevokeSponsorshipOp < XDR::Union
    include XDR::Namespace

    autoload :Signer

    switch_on RevokeSponsorshipType, :type

    switch :revoke_sponsorship_ledger_entry, :ledger_key
    switch :revoke_sponsorship_signer,       :signer

    attribute :ledger_key, LedgerKey
    attribute :signer,     Signer
  end
end

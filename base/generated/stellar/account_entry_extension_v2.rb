# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct AccountEntryExtensionV2
#   {
#       uint32 numSponsored;
#       uint32 numSponsoring;
#       SponsorshipDescriptor signerSponsoringIDs<MAX_SIGNERS>;
#   
#       union switch (int v)
#       {
#       case 0:
#           void;
#       }
#       ext;
#   };
#
# ===========================================================================
module Stellar
  class AccountEntryExtensionV2 < XDR::Struct
    include XDR::Namespace

    autoload :Ext

    attribute :num_sponsored,          Uint32
    attribute :num_sponsoring,         Uint32
    attribute :signer_sponsoring_i_ds, XDR::VarArray[SponsorshipDescriptor, MAX_SIGNERS]
    attribute :ext,                    Ext
  end
end

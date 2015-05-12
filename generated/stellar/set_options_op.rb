# Automatically generated on 2015-05-12T09:08:23-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct SetOptionsOp
#   {
#       AccountID* inflationDest; // sets the inflation destination
#   
#       uint32* clearFlags; // which flags to clear
#       uint32* setFlags;   // which flags to set
#   
#       Thresholds* thresholds; // update the thresholds for the account
#   
#       string32* homeDomain; // sets the home domain
#   
#       // Add, update or remove a signer for the account
#       // signer is deleted if the weight is 0
#       Signer* signer;
#   };
#
# ===========================================================================
module Stellar
  class SetOptionsOp < XDR::Struct
    attribute :inflation_dest, XDR::Option[AccountID]
    attribute :clear_flags,    XDR::Option[Uint32]
    attribute :set_flags,      XDR::Option[Uint32]
    attribute :thresholds,     XDR::Option[Thresholds]
    attribute :home_domain,    XDR::Option[String32]
    attribute :signer,         XDR::Option[Signer]
  end
end

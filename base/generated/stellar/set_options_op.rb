# This code was automatically generated using xdrgen
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
#       // account threshold manipulation
#       uint32* masterWeight; // weight of the master account
#       uint32* lowThreshold;
#       uint32* medThreshold;
#       uint32* highThreshold;
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
    attribute :master_weight,  XDR::Option[Uint32]
    attribute :low_threshold,  XDR::Option[Uint32]
    attribute :med_threshold,  XDR::Option[Uint32]
    attribute :high_threshold, XDR::Option[Uint32]
    attribute :home_domain,    XDR::Option[String32]
    attribute :signer,         XDR::Option[Signer]
  end
end

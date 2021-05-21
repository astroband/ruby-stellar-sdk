# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct CreateAccountOp
#   {
#       AccountID destination; // account to create
#       int64 startingBalance; // amount they end up with
#   };
#
# ===========================================================================
module StellarProtocol
  class CreateAccountOp < XDR::Struct
    attribute :destination,      AccountID
    attribute :starting_balance, Int64
  end
end

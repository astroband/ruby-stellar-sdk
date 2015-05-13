# Automatically generated on 2015-05-13T15:00:04-07:00
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
module Stellar
  class CreateAccountOp < XDR::Struct
    attribute :destination,      AccountID
    attribute :starting_balance, Int64
  end
end

# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union CreateAccountResult switch (CreateAccountResultCode code)
#   {
#   case CREATE_ACCOUNT_SUCCESS:
#       void;
#   default:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class CreateAccountResult < XDR::Union
    switch_on CreateAccountResultCode, :code

    switch :create_account_success
    switch :default

  end
end

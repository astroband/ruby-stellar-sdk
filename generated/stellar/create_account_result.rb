# Automatically generated on 2015-05-13T15:00:04-07:00
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

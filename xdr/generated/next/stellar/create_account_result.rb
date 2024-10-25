# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union CreateAccountResult switch (CreateAccountResultCode code)
#   {
#   case CREATE_ACCOUNT_SUCCESS:
#       void;
#   case CREATE_ACCOUNT_MALFORMED:
#   case CREATE_ACCOUNT_UNDERFUNDED:
#   case CREATE_ACCOUNT_LOW_RESERVE:
#   case CREATE_ACCOUNT_ALREADY_EXIST:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class CreateAccountResult < XDR::Union
    switch_on CreateAccountResultCode, :code

    switch :create_account_success
    switch :create_account_malformed
    switch :create_account_underfunded
    switch :create_account_low_reserve
    switch :create_account_already_exist

  end
end

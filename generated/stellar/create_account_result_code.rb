# Automatically generated on 2015-05-13T15:00:04-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum CreateAccountResultCode
#   {
#       // codes considered as "success" for the operation
#       CREATE_ACCOUNT_SUCCESS = 0, // account was created
#   
#       // codes considered as "failure" for the operation
#       CREATE_ACCOUNT_MALFORMED = 1,   // invalid destination
#       CREATE_ACCOUNT_UNDERFUNDED = 2, // not enough funds in source account
#       CREATE_ACCOUNT_LOW_RESERVE =
#           3, // would create an account below the min reserve
#       CREATE_ACCOUNT_ALREADY_EXIST = 4 // account already exists
#   };
#
# ===========================================================================
module Stellar
  class CreateAccountResultCode < XDR::Enum
    member :create_account_success,       0
    member :create_account_malformed,     1
    member :create_account_underfunded,   2
    member :create_account_low_reserve,   3
    member :create_account_already_exist, 4

    seal
  end
end

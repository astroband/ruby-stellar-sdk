# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SorobanCredentialsType
#   {
#       SOROBAN_CREDENTIALS_SOURCE_ACCOUNT = 0,
#       SOROBAN_CREDENTIALS_ADDRESS = 1
#   };
#
# ===========================================================================
module Stellar
  class SorobanCredentialsType < XDR::Enum
    member :soroban_credentials_source_account, 0
    member :soroban_credentials_address,        1

    seal
  end
end

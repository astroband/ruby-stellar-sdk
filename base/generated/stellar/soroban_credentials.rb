# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union SorobanCredentials switch (SorobanCredentialsType type)
#   {
#   case SOROBAN_CREDENTIALS_SOURCE_ACCOUNT:
#       void;
#   case SOROBAN_CREDENTIALS_ADDRESS:
#       SorobanAddressCredentials address;
#   };
#
# ===========================================================================
module Stellar
  class SorobanCredentials < XDR::Union
    switch_on SorobanCredentialsType, :type

    switch :soroban_credentials_source_account
    switch :soroban_credentials_address,      :address

    attribute :address, SorobanAddressCredentials
  end
end

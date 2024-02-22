# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union SCAddress switch (SCAddressType type)
#   {
#   case SC_ADDRESS_TYPE_ACCOUNT:
#       AccountID accountId;
#   case SC_ADDRESS_TYPE_CONTRACT:
#       Hash contractId;
#   };
#
# ===========================================================================
module Stellar
  class SCAddress < XDR::Union
    switch_on SCAddressType, :type

    switch :sc_address_type_account,  :account_id
    switch :sc_address_type_contract, :contract_id

    attribute :account_id,  AccountID
    attribute :contract_id, Hash
  end
end

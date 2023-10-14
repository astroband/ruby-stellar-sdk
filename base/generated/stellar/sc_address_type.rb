# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum SCAddressType
#   {
#       SC_ADDRESS_TYPE_ACCOUNT = 0,
#       SC_ADDRESS_TYPE_CONTRACT = 1
#   };
#
# ===========================================================================
module Stellar
  class SCAddressType < XDR::Enum
    member :sc_address_type_account,  0
    member :sc_address_type_contract, 1

    seal
  end
end

# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum ClaimAtomType
#   {
#       CLAIM_ATOM_TYPE_V0 = 0,
#       CLAIM_ATOM_TYPE_ORDER_BOOK = 1,
#       CLAIM_ATOM_TYPE_LIQUIDITY_POOL = 2
#   };
#
# ===========================================================================
module Stellar
  class ClaimAtomType < XDR::Enum
    member :claim_atom_type_v0,             0
    member :claim_atom_type_order_book,     1
    member :claim_atom_type_liquidity_pool, 2

    seal
  end
end

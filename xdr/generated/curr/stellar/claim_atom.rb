# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union ClaimAtom switch (ClaimAtomType type)
#   {
#   case CLAIM_ATOM_TYPE_V0:
#       ClaimOfferAtomV0 v0;
#   case CLAIM_ATOM_TYPE_ORDER_BOOK:
#       ClaimOfferAtom orderBook;
#   case CLAIM_ATOM_TYPE_LIQUIDITY_POOL:
#       ClaimLiquidityAtom liquidityPool;
#   };
#
# ===========================================================================
module Stellar
  class ClaimAtom < XDR::Union
    switch_on ClaimAtomType, :type

    switch :claim_atom_type_v0,             :v0
    switch :claim_atom_type_order_book,     :order_book
    switch :claim_atom_type_liquidity_pool, :liquidity_pool

    attribute :v0,             ClaimOfferAtomV0
    attribute :order_book,     ClaimOfferAtom
    attribute :liquidity_pool, ClaimLiquidityAtom
  end
end

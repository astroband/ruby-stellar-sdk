# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union TransactionPhase switch (int v)
#   {
#   case 0:
#       TxSetComponent v0Components<>;
#   };
#
# ===========================================================================
module Stellar
  class TransactionPhase < XDR::Union
    switch_on XDR::Int, :v

    switch 0, :v0_components

    attribute :v0_components, XDR::VarArray[TxSetComponent]
  end
end

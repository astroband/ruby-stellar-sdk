# Automatically generated on 2015-05-12T09:08:23-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum OperationType
#   {
#       PAYMENT = 0,
#       CREATE_OFFER = 1,
#       SET_OPTIONS = 2,
#       CHANGE_TRUST = 3,
#       ALLOW_TRUST = 4,
#       ACCOUNT_MERGE = 5,
#       INFLATION = 6
#   };
#
# ===========================================================================
module Stellar
  class OperationType < XDR::Enum
    member :payment,       0
    member :create_offer,  1
    member :set_options,   2
    member :change_trust,  3
    member :allow_trust,   4
    member :account_merge, 5
    member :inflation,     6

    seal
  end
end

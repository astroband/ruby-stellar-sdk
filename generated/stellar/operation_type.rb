# Automatically generated on 2015-05-13T15:00:04-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum OperationType
#   {
#       CREATE_ACCOUNT = 0,
#       PAYMENT = 1,
#       PATH_PAYMENT = 2,
#       CREATE_OFFER = 3,
#       SET_OPTIONS = 4,
#       CHANGE_TRUST = 5,
#       ALLOW_TRUST = 6,
#       ACCOUNT_MERGE = 7,
#       INFLATION = 8
#   };
#
# ===========================================================================
module Stellar
  class OperationType < XDR::Enum
    member :create_account, 0
    member :payment,        1
    member :path_payment,   2
    member :create_offer,   3
    member :set_options,    4
    member :change_trust,   5
    member :allow_trust,    6
    member :account_merge,  7
    member :inflation,      8

    seal
  end
end

# Automatically generated on 2015-06-08T11:39:14-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   enum OperationType
#   {
#       CREATE_ACCOUNT = 0,
#       PAYMENT = 1,
#       PATH_PAYMENT = 2,
#       MANAGE_OFFER = 3,
#   	CREATE_PASSIVE_OFFER = 4,
#       SET_OPTIONS = 5,
#       CHANGE_TRUST = 6,
#       ALLOW_TRUST = 7,
#       ACCOUNT_MERGE = 8,
#       INFLATION = 9
#   };
#
# ===========================================================================
module Stellar
  class OperationType < XDR::Enum
    member :create_account,       0
    member :payment,              1
    member :path_payment,         2
    member :manage_offer,         3
    member :create_passive_offer, 4
    member :set_options,          5
    member :change_trust,         6
    member :allow_trust,          7
    member :account_merge,        8
    member :inflation,            9

    seal
  end
end

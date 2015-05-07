# Automatically generated on 2015-05-07T07:56:23-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   struct Operation
#   {
#       // sourceAccount is the account used to run the operation
#       // if not set, the runtime defaults to "account" specified at
#       // the transaction level
#       AccountID* sourceAccount;
#   
#       union switch (OperationType type)
#       {
#       case PAYMENT:
#           PaymentOp paymentOp;
#       case CREATE_OFFER:
#           CreateOfferOp createOfferOp;
#       case SET_OPTIONS:
#           SetOptionsOp setOptionsOp;
#       case CHANGE_TRUST:
#           ChangeTrustOp changeTrustOp;
#       case ALLOW_TRUST:
#           AllowTrustOp allowTrustOp;
#       case ACCOUNT_MERGE:
#           uint256 destination;
#       case INFLATION:
#           void;
#       }
#       body;
#   };
#
# ===========================================================================
module Stellar
  class Operation < XDR::Struct
    include XDR::Namespace

    autoload :Body

    attribute :source_account, XDR::Option[AccountID]
    attribute :body,           Body
  end
end

# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union OperationID switch (EnvelopeType type)
#   {
#   case ENVELOPE_TYPE_OP_ID:
#       struct
#       {
#           MuxedAccount sourceAccount;
#           SequenceNumber seqNum;
#           uint32 opNum;
#       } id;
#   };
#
# ===========================================================================
module Stellar
  class OperationID < XDR::Union
    include XDR::Namespace

    autoload :Id

    switch_on EnvelopeType, :type

    switch :envelope_type_op_id, :id

    attribute :id, Id
  end
end

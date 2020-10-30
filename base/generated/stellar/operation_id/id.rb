# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           MuxedAccount sourceAccount;
#           SequenceNumber seqNum;
#           uint32 opNum;
#       }
#
# ===========================================================================
module Stellar
  class OperationID
    class Id < XDR::Struct
      attribute :source_account, MuxedAccount
      attribute :seq_num,        SequenceNumber
      attribute :op_num,         Uint32
    end
  end
end

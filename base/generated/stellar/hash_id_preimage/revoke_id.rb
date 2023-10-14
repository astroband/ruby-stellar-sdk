# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           AccountID sourceAccount;
#           SequenceNumber seqNum; 
#           uint32 opNum;
#           PoolID liquidityPoolID;
#           Asset asset;
#       }
#
# ===========================================================================
module Stellar
  class HashIDPreimage
    class RevokeID < XDR::Struct
      attribute :source_account,    AccountID
      attribute :seq_num,           SequenceNumber
      attribute :op_num,            Uint32
      attribute :liquidity_pool_id, PoolID
      attribute :asset,             Asset
    end
  end
end

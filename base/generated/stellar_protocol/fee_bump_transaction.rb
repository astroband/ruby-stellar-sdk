# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct FeeBumpTransaction
#   {
#       MuxedAccount feeSource;
#       int64 fee;
#       union switch (EnvelopeType type)
#       {
#       case ENVELOPE_TYPE_TX:
#           TransactionV1Envelope v1;
#       }
#       innerTx;
#       union switch (int v)
#       {
#       case 0:
#           void;
#       }
#       ext;
#   };
#
# ===========================================================================
module StellarProtocol
  class FeeBumpTransaction < XDR::Struct
    include XDR::Namespace

    autoload :InnerTx
    autoload :Ext

    attribute :fee_source, MuxedAccount
    attribute :fee,        Int64
    attribute :inner_tx,   InnerTx
    attribute :ext,        Ext
  end
end

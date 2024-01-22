# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct StellarValue
#   {
#       Hash txSetHash;      // transaction set to apply to previous ledger
#       TimePoint closeTime; // network close time
#   
#       // upgrades to apply to the previous ledger (usually empty)
#       // this is a vector of encoded 'LedgerUpgrade' so that nodes can drop
#       // unknown steps during consensus if needed.
#       // see notes below on 'LedgerUpgrade' for more detail
#       // max size is dictated by number of upgrade types (+ room for future)
#       UpgradeType upgrades<6>;
#   
#       // reserved for future use
#       union switch (StellarValueType v)
#       {
#       case STELLAR_VALUE_BASIC:
#           void;
#       case STELLAR_VALUE_SIGNED:
#           LedgerCloseValueSignature lcValueSignature;
#       }
#       ext;
#   };
#
# ===========================================================================
module Stellar
  class StellarValue < XDR::Struct
    include XDR::Namespace

    autoload :Ext

    attribute :tx_set_hash, Hash
    attribute :close_time,  TimePoint
    attribute :upgrades,    XDR::VarArray[UpgradeType, 6]
    attribute :ext,         Ext
  end
end

# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct DataEntry
#   {
#       AccountID accountID; // account this data belongs to
#       string64 dataName;
#       DataValue dataValue;
#   
#       // reserved for future use
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
  class DataEntry < XDR::Struct
    include XDR::Namespace

    autoload :Ext

    attribute :account_id, AccountID
    attribute :data_name,  String64
    attribute :data_value, DataValue
    attribute :ext,        Ext
  end
end

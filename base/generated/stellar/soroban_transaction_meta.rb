# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct SorobanTransactionMeta
#   {
#       ExtensionPoint ext;
#
#       ContractEvent events<>;             // custom events populated by the
#                                           // contracts themselves.
#       SCVal returnValue;                  // return value of the host fn invocation
#
#       // Diagnostics events that are not hashed.
#       // This will contain all contract and diagnostic events. Even ones
#       // that were emitted in a failed contract call.
#       DiagnosticEvent diagnosticEvents<>;
#   };
#
# ===========================================================================
module Stellar
  class SorobanTransactionMeta < XDR::Struct
    attribute :ext,               ExtensionPoint
    attribute :events,            XDR::VarArray[ContractEvent]
    attribute :return_value,      SCVal
    attribute :diagnostic_events, XDR::VarArray[DiagnosticEvent]
  end
end

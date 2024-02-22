# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct OperationDiagnosticEvents
#   {
#       DiagnosticEvent events<>;
#   };
#
# ===========================================================================
module Stellar
  class OperationDiagnosticEvents < XDR::Struct
    attribute :events, XDR::VarArray[DiagnosticEvent]
  end
end

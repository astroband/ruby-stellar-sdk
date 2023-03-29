# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct DiagnosticEvent
#   {
#       bool inSuccessfulContractCall;
#       ContractEvent event;
#   };
#
# ===========================================================================
module Stellar
  class DiagnosticEvent < XDR::Struct
    attribute :in_successful_contract_call, XDR::Bool
    attribute :event,                       ContractEvent
  end
end

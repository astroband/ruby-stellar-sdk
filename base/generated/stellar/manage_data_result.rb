# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union ManageDataResult switch (ManageDataResultCode code)
#   {
#   case MANAGE_DATA_SUCCESS:
#       void;
#   default:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class ManageDataResult < XDR::Union
    switch_on ManageDataResultCode, :code

    switch :manage_data_success
    switch :default

  end
end

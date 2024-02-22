# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union ManageDataResult switch (ManageDataResultCode code)
#   {
#   case MANAGE_DATA_SUCCESS:
#       void;
#   case MANAGE_DATA_NOT_SUPPORTED_YET:
#   case MANAGE_DATA_NAME_NOT_FOUND:
#   case MANAGE_DATA_LOW_RESERVE:
#   case MANAGE_DATA_INVALID_NAME:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class ManageDataResult < XDR::Union
    switch_on ManageDataResultCode, :code

    switch :manage_data_success
    switch :manage_data_not_supported_yet
    switch :manage_data_name_not_found
    switch :manage_data_low_reserve
    switch :manage_data_invalid_name

  end
end

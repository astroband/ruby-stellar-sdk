# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum ManageDataResultCode
#   {
#       // codes considered as "success" for the operation
#       MANAGE_DATA_SUCCESS = 0,
#       // codes considered as "failure" for the operation
#       MANAGE_DATA_NOT_SUPPORTED_YET =
#           -1, // The network hasn't moved to this protocol change yet
#       MANAGE_DATA_NAME_NOT_FOUND =
#           -2, // Trying to remove a Data Entry that isn't there
#       MANAGE_DATA_LOW_RESERVE = -3, // not enough funds to create a new Data Entry
#       MANAGE_DATA_INVALID_NAME = -4 // Name not a valid string
#   };
#
# ===========================================================================
module StellarProtocol
  class ManageDataResultCode < XDR::Enum
    member :manage_data_success,           0
    member :manage_data_not_supported_yet, -1
    member :manage_data_name_not_found,    -2
    member :manage_data_low_reserve,       -3
    member :manage_data_invalid_name,      -4

    seal
  end
end

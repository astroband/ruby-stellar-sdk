# Automatically generated on 2015-05-12T09:08:23-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

# === xdr source ============================================================
#
#   union SetOptionsResult switch (SetOptionsResultCode code)
#   {
#   case SET_OPTIONS_SUCCESS:
#       void;
#   default:
#       void;
#   };
#
# ===========================================================================
module Stellar
  class SetOptionsResult < XDR::Union
    switch_on SetOptionsResultCode, :code

    switch :set_options_success
    switch :default

  end
end

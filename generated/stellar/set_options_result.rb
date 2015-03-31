# Automatically generated on 2015-03-31T14:32:44-07:00
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

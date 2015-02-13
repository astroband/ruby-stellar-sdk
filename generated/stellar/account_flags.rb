# Automatically generated from xdr/Stellar-ledger-entries.x
# DO NOT EDIT or your changes may be overwritten
      
require 'xdr'
__dir__ = File.dirname(__FILE__)

module Stellar
  class AccountFlag < XDR::Enum
    member :auth_required_flag, 1

    seal
  end
end

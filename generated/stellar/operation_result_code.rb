# Automatically generated on 2015-03-30T09:46:31-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class OperationResultCode < XDR::Enum
    member :op_skip,       0
    member :op_inner,      1
    member :op_bad_auth,   2
    member :op_no_account, 3

    seal
  end
end

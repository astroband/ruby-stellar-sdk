# Automatically generated on 2015-03-30T09:46:32-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  module AccountMerge
    class AccountMergeResult < XDR::Union
      switch_on AccountMergeResultCode, :code

      switch :success
      switch :default

    end
  end
end

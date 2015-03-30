# Automatically generated on 2015-03-30T09:46:31-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class TransactionResultCode < XDR::Enum
    member :tx_success,              0
    member :tx_failed,               1
    member :tx_bad_ledger,           2
    member :tx_duplicate,            3
    member :tx_malformed,            4
    member :tx_bad_seq,              5
    member :tx_bad_auth,             6
    member :tx_insufficient_balance, 7
    member :tx_no_account,           8
    member :tx_insufficient_fee,     9

    seal
  end
end

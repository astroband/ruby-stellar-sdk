# Automatically generated on 2015-03-30T09:46:31-07:00
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  class LedgerKey < XDR::Union
    include XDR::Namespace

    autoload :Account
    autoload :TrustLine
    autoload :Offer

    switch_on LedgerEntryType, :type

    switch :account,   :account
    switch :trustline, :trust_line
    switch :offer,     :offer

    attribute :account,    Account
    attribute :trust_line, TrustLine
    attribute :offer,      Offer
  end
end

module Stellar
  class AccountFlags
    #
    # Converts an array of Stellar::AccountFlags members into
    # an Integer suitable for use in a SetOptionsOp.
    #
    # @param flags [Array<Stellar::AccountFlags>] the flags to combine
    #
    # @return [Fixnum] the combined result
    def self.make_mask(flags = nil)
      flags ||= []

      flags.map(&:value).inject(&:|) || 0
    end

    #
    # Converts an integer used in SetOptionsOp on the set/clear flag options
    # into an array of Stellar::AccountFlags members
    #
    #  @param combined [Fixnum]
    #  @return [Array<Stellar::AccountFlags>]
    def self.parse_mask(combined)
      members.values.select { |m| (m.value & combined) != 0 }
    end
  end
end

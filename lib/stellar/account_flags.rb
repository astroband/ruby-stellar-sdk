module Stellar
  class AccountFlags


    # 
    # Converts an array of Stellar::AccountFlags members into
    # an Integer suitable for use in a SetOptionsOp.
    # 
    # @param flags=nil [Array<Stellar::AccountFlags>] the flags to combine
    # 
    # @return [Fixnum] the combined result
    def self.make_mask(flags=nil)
      flags ||= []

      flags.map(&:value).inject(&:|) || 0
    end

  end
end
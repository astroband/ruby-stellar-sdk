module Stellar
  class Thresholds
    COMPONENTS = [:master_weight, :low, :medium, :high]
    VALID_RANGE = 0..255

    class << self
      def make(thresholds = {})
        # error if any of the needed components are not provided
        if COMPONENTS.any? { |c| thresholds[c].blank? }
          raise ArgumentError, "invalid thresholds hash, must have #{COMPONENTS.inspect} keys, had: #{thresholds.keys.inspect}"
        end

        # error if any of the needed components are not numbers 0 <= N <= 255
        COMPONENTS.each do |c|
          good = true

          good &&= thresholds[c].is_a?(Integer)
          good &&= VALID_RANGE.include? thresholds[c]

          unless good
            raise ArgumentError, "invalid #{c.inspect}, must be number in (0..255), got #{thresholds[c].inspect}"
          end
        end

        thresholds.values_at(*COMPONENTS).pack("C*")
      end

      def parse(combined)
        master_weight, low, medium, high = combined.unpack("C*")
        {
          master_weight: master_weight,
          low: low,
          medium: medium,
          high: high
        }
      end
    end
  end
end

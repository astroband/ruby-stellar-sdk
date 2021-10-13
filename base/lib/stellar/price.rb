module Stellar
  # reopen class
  class Price
    MAX_PRECISION = (2**31) - 1

    def self.from(number)
      number = BigDecimal(number, 0) if number.is_a?(String)
      number = number.to_r if number.respond_to?(:to_r)

      raise ArgumentError, "Couldn't convert #{number.class} to rational number" unless number.is_a?(Rational)

      best_r = number.rationalize(1.0e-7)

      if best_r.numerator > MAX_PRECISION || best_r.denominator > MAX_PRECISION
        raise ArgumentError, "Couldn't find valid price approximation for #{number}"
      end

      new(n: best_r.numerator, d: best_r.denominator)
    end

    def invert
      self.class.new(n: d, d: n)
    end

    def to_r
      Rational(n, d)
    end

    def to_d
      n.to_d / d
    end

    def to_f
      n.to_f / d
    end

    def to_s
      "#{n} / #{d}"
    end

    def inspect
      "#<Stellar::Price #{self}>"
    end
  end
end

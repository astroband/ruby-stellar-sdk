module Stellar
  # reopen class
  class Price
    MAX_PRECISION = (2**31) - 1

    def self.from_f(number)
      best_r = number.to_r.rationalize(1.0e-7)

      if best_r.numerator > MAX_PRECISION || best_r.denominator > MAX_PRECISION
        raise ArgumentError("Couldn't find price approximation")
      end

      new({
        n: best_r.numerator,
        d: best_r.denominator
      })
    end

    def invert
      self.class.new(n: d, d: n)
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

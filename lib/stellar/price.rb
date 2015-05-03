module Stellar

  # reopen class
  class Price

    MAX_PRECISION = (2**31) - 1

    def self.from_f(number)
      best_r = Util::ContinuedFraction.best_r(number, MAX_PRECISION)
      new({
        n: best_r.numerator,
        d: best_r.denominator
      })
    end

    def invert
      self.class.new(n:d,d:n)
    end

    def to_f
      n / d.to_f
    end

    def to_s
      "#{n} / #{d}"
    end

    def inspect
      "#<Stellar::Price #{self}>"
    end
  end
end
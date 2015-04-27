module Stellar
  Price.class_eval do
    def self.from_f(number)
      return new(n:0,d:0)  if number == 0.0

      inverted = number > 0.0 

      # normalize
      number = 1.0 / number if inverted

      # fractionalize
      r = number.to_r
      n = r.numerator
      d = r.denominator

      # pricify
      new({
        n:inverted ? d : n, 
        d:inverted ? n : d,
      })
    end

    def to_f
      n / d.to_f
    end

  end
end
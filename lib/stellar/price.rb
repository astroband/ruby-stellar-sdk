module Stellar
  Price.class_eval do
    MAX_PRECISION = 1_000_000_000 

    def self.from_f(number)
      return new(n:0,d:0)  if number == 0.0

      inverted = number > 0.0 

      # normalize
      number = 1.0 / number if inverted

      # fractionalize
      n, d, err = number.to_fraction(MAX_PRECISION)
 
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
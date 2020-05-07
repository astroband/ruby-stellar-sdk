module Stellar
  module Util
    class ContinuedFraction
      MAX_PRECISION = (2**32) - 1
      attr_reader :i
      attr_reader :f

      def self.best_r(number, max_precision = MAX_PRECISION)
        cur_cf = new(number)

        loop do
          next_cf = cur_cf.extend
          cur_r = cur_cf.to_r(max_precision)
          next_r = next_cf.to_r(max_precision)

          break cur_r if cur_cf.done? || cur_r == next_r

          cur_cf = next_cf
        end

        cur_cf.to_r(max_precision)
      end

      def initialize(val, parents = [])
        @i = val.floor
        @f = val - @i
        @parents = parents
      end

      def to_a
        @parents + [i]
      end

      def error(actual)
        (actual - to_f).abs
      end

      def to_f
        convergent = convergents.last
        convergent.n / convergent.d.to_f
      end

      def convergents
        return @convergents if defined? @convergents

        c = [Fraction.new(0, 1), Fraction.new(1, 0)]
        to_a.each_with_index do |a, i|
          i += 2

          h = a * c[i - 1].n + c[i - 2].n
          k = a * c[i - 1].d + c[i - 2].d
          c << Fraction.new(h, k)
        end

        @converegents = c[2..-1]
      end

      def to_r(max_precision = MAX_PRECISION)
        fraction = convergents.take_while { |c|
          c.n <= max_precision && c.d <= max_precision
        }.last

        Rational(fraction.n, fraction.d)
      end

      def done?
        @f == 0
      end

      def extend(count = 1)
        result = self

        count.times do
          break if result.done?
          result = ContinuedFraction.new(1 / result.f, result.to_a)
        end

        result
      end

      class Fraction
        attr_reader :n
        attr_reader :d

        def initialize(n, d)
          @n = n
          @d = d
        end

        def to_r
          Rational(@n, @d)
        end
      end
    end
  end
end

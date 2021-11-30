# frozen_string_literals: true
require "active_support/core_ext/integer/time"
require "active_support/core_ext/string/conversions"
require "active_support/core_ext/hash/indifferent_access"

module Stellar
  # Represents claim predicate on Stellar network.
  #
  # @see https://developers.stellar.org/docs/glossary/claimable-balance/
  class ClaimPredicate
    module FactoryMethods
      # Constructs an `unconditional` claim predicate.
      #
      # This predicate will be always fulfilled.
      #
      # @return [ClaimPredicate] `unconditional` claim predicate
      def unconditional
        ClaimPredicate.new(ClaimPredicateType::UNCONDITIONAL)
      end

      # Constructs a `before_relative_time` claim predicate.
      #
      # This predicate will be fulfilled if the closing time of the ledger that includes
      # the Stellar::CreateClaimableBalance operation plus this relative time delta (in seconds)
      # is less than the current time.
      #
      # @param seconds [#to_int|#to_i] seconds since `closeTime` of the ledger in which
      #                                the ClaimableBalanceEntry was created.
      # @return [ClaimPredicate] `before_relative_time` claim predicate
      def before_relative_time(seconds)
        ClaimPredicate.new(ClaimPredicateType::BEFORE_RELATIVE_TIME, Integer(seconds))
      end

      # Constructs an `before_absolute_time` claim predicate.
      #
      # This predicate will be fulfilled if the closing time of the ledger that includes
      # the Stellar::CreateClaimableBalance operation is less than provided timestamp.
      #
      # @param timestamp [#to_time|#to_int|#to_i] time value or timestamp
      #
      # @return [ClaimPredicate] `before_absolute_time` claim predicate.
      def before_absolute_time(timestamp)
        timestamp = timestamp.to_time if timestamp.respond_to?(:to_time)

        ClaimPredicate.new(ClaimPredicateType::BEFORE_ABSOLUTE_TIME, Integer(timestamp))
      end

      # Constructs either relative or absolute time predicate based on the type of the input.
      #
      # If input is an instance of `ActiveSupport::Duration` class it will be handled as a relative time
      # (seconds since close time of the ledger), otherwise it will be treated as an absolute time.
      #
      # It is intended to work with time helpers provided by ActiveSupport, like `1.day` (relative)
      # or `2.weeks.from_now` (absolute).
      #
      # @example relative time
      #   ClaimPredicate.before(2.days + 15.seconds)
      #
      # @example absolute time
      #   ClaimPredicate.before(5.hours.from_now)
      #
      # @param time [ActiveSupport::Duration|#to_time|#to_i] duration since ledger close time or absolute time value
      #
      # @return [ClaimPredicate] `before_relative_time` or `before_absolute_time` claim predicate.
      def before(time)
        ActiveSupport::Duration === time ? before_relative_time(time.to_i) : before_absolute_time(time)
      end

      # Constructs a negated predicate from either relative or absolute time based on the type of the input.
      #
      # @see #before
      # @param (see #before)
      # @return (see #before)
      def after(time)
        ~before(time)
      end

      # Compose a predicate from json-like hash.
      # Useful for parsing Horizon output
      #
      # @example:
      #   ClaimPredicate.parse(
      #     "and" => [
      #       { "not" => { "abs_before" => "2021-09-17T09:59:34Z" } },
      #       { "abs_before" => "2021-10-17T09:59:34Z" }
      #     ]
      #   )
      #
      # @param object [Hash] see example for the format
      # @return [ClaimPredicate]
      def parse(object)
        object = object.with_indifferent_access

        # binding.irb
        if object["unconditional"]
          return unconditional
        end

        if object["not"]
          return parse(object["not"]).not
        end

        method, args = object.to_a.first

        if %w[and or].include?(method)
          unless args.is_a?(Array)
            raise ArgumentError, "invalid arguments #{args} for predicate '#{method}'"
          end

          parse(args[0]).public_send(method, parse(args[1]))
        else
          callable_method = {
            "abs_before" => :before_absolute_time,
            "rel_before" => :before_relative_time
          }[method]

          if callable_method.blank?
            raise ArgumentError, "Unknown predicate '#{method}'"
          end

          public_send(callable_method, args)
        end
      end

      # Compose a complex predicate by calling DSL methods from the block.
      #
      # @example
      #   ClaimPredicate.compose {
      #     after(15.minutes) & before(1.day) | after(1.week.from_now) & before(1.week.from_now + 1.day)
      #   }
      #
      # @yieldreturn [ClaimPredicate|nil]
      # @return [ClaimPredicate] `not(before_relative_time)` or `not(before_absolute_time)` claim predicate.
      def compose(&block)
        result = instance_eval(&block)
        result.nil? ? unconditional : result
      end
    end

    extend FactoryMethods

    # Constructs an `and` claim predicate.
    #
    # This predicate will be fulfilled if both `self` and `other` predicates are fulfilled.
    #
    # @param other [ClaimPredicate] another predicate
    #
    # @return [ClaimPredicate] `and` claim predicate
    def and(other)
      raise TypeError, "no conversion from #{other.class.name} to ClaimPredicate" unless ClaimPredicate === other
      ClaimPredicate.new(ClaimPredicateType::AND, [self, other])
    end
    alias_method :&, :and

    # Constructs an `or` claim predicate.
    #
    # This predicate will be fulfilled if either of `self` or `other` predicates is fulfilled.
    #
    # @param other [ClaimPredicate] another predicate.
    #
    # @return [ClaimPredicate] `or` claim predicate
    def or(other)
      raise TypeError, "no conversion from #{other.class.name} to ClaimPredicate" unless ClaimPredicate === other
      ClaimPredicate.new(ClaimPredicateType::OR, [self, other])
    end
    alias_method :|, :or

    # Constructs a `not` claim predicate.
    #
    # This predicate will be fulfilled if `self` is not fulfilled.
    #
    # @return [ClaimPredicate] `not` claim predicate
    def not
      ClaimPredicate.new(ClaimPredicateType::NOT, self)
    end
    alias_method :~@, :not

    # Evaluates the predicate value for provided inputs.
    #
    # @param created_at [#to_time|#to_int] closing time of the ledger containing CreateClaimableBalance operation
    # @param claiming_at [#to_time|#to_int|ActiveSupport::Duration] time point to evaluate predicate at, either
    #   absolute time or duration relative to `created_at`. In reality predicate will be evaluated by stellar-core
    #   using the closing time of a ledger containing ClaimClaimableBalance operation, in either successful
    #   or failed state.
    #
    # @return [Boolean] `true` if this predicate would allow claiming the balance, `false` otherwise
    def evaluate(created_at, claiming_at)
      created_at = created_at.to_time if created_at.respond_to?(:to_time)
      claiming_at = created_at + claiming_at if claiming_at.is_a?(ActiveSupport::Duration)
      claiming_at = claiming_at.to_time if claiming_at.respond_to?(:to_time)

      return false if claiming_at < created_at

      case switch
      when ClaimPredicateType::UNCONDITIONAL
        true
      when ClaimPredicateType::BEFORE_RELATIVE_TIME
        Integer(claiming_at) < Integer(created_at) + value
      when ClaimPredicateType::BEFORE_ABSOLUTE_TIME
        Integer(claiming_at).to_i < value
      when ClaimPredicateType::AND
        value[0].evaluate(created_at, claiming_at) && value[1].evaluate(created_at, claiming_at)
      when ClaimPredicateType::OR
        value[0].evaluate(created_at, claiming_at) || value[1].evaluate(created_at, claiming_at)
      when ClaimPredicateType::NOT
        !value.evaluate(created_at, claiming_at)
      else
        raise ArgumentError, "evaluation is not implemented for #{switch.name} predicate"
      end
    end

    def describe
      case switch
      when ClaimPredicateType::UNCONDITIONAL
        "always"
      when ClaimPredicateType::BEFORE_RELATIVE_TIME
        dur = ActiveSupport::Duration.build(value)
        "less than #{dur.inspect} since creation"
      when ClaimPredicateType::BEFORE_ABSOLUTE_TIME
        "before #{Time.at(value).to_formatted_s(:db)}"
      when ClaimPredicateType::AND
        value.map(&:describe).join(" and ")
      when ClaimPredicateType::OR
        "(" << value.map(&:describe).join(" or ") << ")"
      when ClaimPredicateType::NOT
        case value.switch
        when ClaimPredicateType::UNCONDITIONAL
          "never"
        when ClaimPredicateType::BEFORE_RELATIVE_TIME
          dur = ActiveSupport::Duration.build(value.value)
          "#{dur.inspect} or more since creation"
        when ClaimPredicateType::BEFORE_ABSOLUTE_TIME
          "after #{Time.at(value.value).to_formatted_s(:db)}"
        else
          "not (#{value.describe})"
        end
      else
        raise ArgumentError, "evaluation is not implemented for #{switch.name} predicate"
      end
    end

    def inspect
      "#<ClaimPredicate: #{describe}>"
    end
  end
end

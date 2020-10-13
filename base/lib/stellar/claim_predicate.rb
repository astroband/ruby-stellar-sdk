# frozen_string_literals: true
require "active_support/core_ext/integer/time"

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
      # @param timestamp [#to_int|#to_i] Unix epoch.
      #
      # @return [ClaimPredicate] `before_absolute_time` claim predicate.
      def before_absolute_time(timestamp)
        ClaimPredicate.new(ClaimPredicateType::BEFORE_ABSOLUTE_TIME, Integer(timestamp))
      end

      def construct(&block)
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
      raise ArgumentError, "no conversion from #{other.class.name} to ClaimPredicate" unless other.is_a?(ClaimPredicate)
      ClaimPredicate.new(ClaimPredicateType::AND, [self, other])
    end
    alias & and

    # Constructs an `or` claim predicate.
    #
    # This predicate will be fulfilled if either of `self` or `other` predicates is fulfilled.
    #
    # @param other [ClaimPredicate] another predicate.
    #
    # @return [ClaimPredicate] `or` claim predicate
    def or(other)
      raise ArgumentError, "no conversion from #{other.class.name} to ClaimPredicate" unless other.is_a?(ClaimPredicate)
      ClaimPredicate.new(ClaimPredicateType::OR, [self, other])
    end
    alias | or

    # Constructs a `not` claim predicate.
    #
    # This predicate will be fulfilled if `self` is not fulfilled.
    #
    # @return [ClaimPredicate] `not` claim predicate
    def not
      ClaimPredicate.new(ClaimPredicateType::NOT, self)
    end
    alias ~@ not
  end
end

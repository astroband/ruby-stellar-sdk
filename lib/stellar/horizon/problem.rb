# frozen_string_literal: true

module Stellar
  module Horizon
    class Problem
      include Contracts

      def initialize(attributes)
        @attributes = attributes.reverse_merge({
                                                 type: 'about:blank',
                                                 title: 'Unknown Error',
                                                 status: 500
                                               })

        @meta = @attributes.except!(:type, :title, :status, :detail, :instance)
      end

      Contract None => String
      def type
        @attributes[:type]
      end

      Contract None => String
      def title
        @attributes[:title]
      end

      Contract None => Num
      def status
        @attributes[:status]
      end

      Contract None => String
      def detail
        @attributes[:detail]
      end

      Contract None => String
      def instance
        @attributes[:instance]
      end

      Contract None => HashOf[String, Any]
      def meta
        @attributes[:instance]
      end
    end
  end
end

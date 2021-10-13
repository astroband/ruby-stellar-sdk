module Stellar
  module Horizon
    class Problem
      def initialize(attributes)
        @attributes = attributes.reverse_merge({
          type: "about:blank",
          title: "Unknown Error",
          status: 500
        })

        @meta = @attributes.except!(:type, :title, :status, :detail, :instance)
      end

      # @return [String]
      def type
        @attributes[:type]
      end

      # @return [String]
      def title
        @attributes[:title]
      end

      # @return [Integer]
      def status
        @attributes[:status]
      end

      # @return [String]
      def detail
        @attributes[:detail]
      end

      # @return [String]
      def instance
        @attributes[:instance]
      end

      # @return [{String => Object}]
      def meta
        @attributes[:instance]
      end
    end
  end
end

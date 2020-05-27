module Stellar
  class TransactionPage
    include Enumerable

    # @param [Hyperclient::Link] resource
    def initialize(resource)
      @resource = resource
    end

    def each
      @resource.records.each do |tx|
        yield tx if block_given?
      end
    end

    # @return [Stellar::TransactionPage]
    def next_page
      self.class.new(@resource.next)
    end

    def next_page!
      @resource = @resource.next
    end
  end
end

module Stellar
  class TransactionPage
    include Contracts
    include Enumerable

    Contract Hyperclient::Link => Any
    def initialize(resource)
      @resource = resource
    end

    def each
      @resource.records.each do |tx|
        yield tx if block_given?
      end  
    end

    Contract None => TransactionPage
    def next_page
      self.class.new(@resource.next)
    end

    def next_page!
      @resource = @resource.next
    end

  end
end
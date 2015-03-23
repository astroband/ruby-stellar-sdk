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
      new(@resource.next)
    end

    def next_page!
      @resource = @resouce.next
    end

  end
end
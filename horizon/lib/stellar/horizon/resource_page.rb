module Stellar::Horizon
  class ResourcePage
    include Enumerable
    include Stellar::DSL

    # @param [Hyperclient::Link] resource
    def initialize(resource)
      @resource = resource
    end

    def each
      @resource.records.each do |record|
        yield objectify(record) if block_given?
      end
    end

    # @return [Stellar::ResourcePage]
    def next_page
      self.class.new(@resource.next)
    end

    def next_page!
      @resource = @resource.next
    end

    private

    def objectify(record)
      record
    end
  end
end

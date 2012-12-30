module Warehouse
  class Repository
    attr_accessor :collection_source, :model_class, :query_object

    def initialize(options = {})
      raise Warehouse::Exceptions::ModelClassRequired unless options.keys.include?(:model_class)

      @collection_source = options[:collection_source] || -> {
        @in_memory_collection ? @in_memory_collection : @in_memory_collection = Warehouse::Storages::InMemory.new
      }

      @query_object = options[:query_object] || ->(repo) {
        collection
      }
    end

    def fetch_all
      filter
    end

    def store(object)
      collection << object
    end

    def collection
      @collection_source.call
    end

    private

    def filter
      @query_object.call(self)
    end
  end
end

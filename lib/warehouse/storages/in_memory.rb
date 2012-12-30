module Warehouse
  module Storages
    class InMemory < Array
      def <<(element)
        super(element) unless include?(element)
      end
    end
  end
end

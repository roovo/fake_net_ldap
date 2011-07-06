module FakeNetLdap
  class Registry #:nodoc:
    include Singleton

    def initialize
      clear_query_registrations
    end

    def clear_query_registrations
      @query_map = {}
    end

    def query_registered?(query)
      @query_map.has_key?(query) || @query_map.has_key?(:unregistered_query)
    end

    def register_query(query, response)
      @query_map[query] = FakeNetLdap::Responder.new(query, response)
    end
  end
end


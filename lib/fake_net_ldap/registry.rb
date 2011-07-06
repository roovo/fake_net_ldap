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

    def response_for(query, &block)
      registered = query_registered?(query)
      if registered && @query_map.has_key?(query)
        response = @query_map[query]
      elsif registered
        response = @query_map[:unregistered_query]
      else
        return nil
      end

      response.respond(&block)
    end
  end
end


module FakeNetLdap

  class Registry #:nodoc:

    include Singleton

    def initialize
      clear_query_registrations
      clear_user_registrations
    end

    def clear_user_registrations
      @user_map = {}
    end

    def register_user(attrs)
      @user_map[attrs[:username]] = attrs[:password]
    end

    def user_registered?(attrs)
      @user_map.has_key?(attrs[:username]) && (@user_map[attrs[:username]] == attrs[:password])
    end

    def clear_query_registrations
      @query_map = {}
    end

    def register_query(query, response)
      @query_map[query.to_s] = FakeNetLdap::Responder.new(query, response)
    end

    def query_registered?(query)
      @query_map.has_key?(query.to_s) || @query_map.has_key?('unregistered_query')
    end

    def response_for(query, &block)
      registered = query_registered?(query.to_s)
      if registered && @query_map.has_key?(query.to_s)
        response = @query_map[query.to_s]
      elsif registered
        response = @query_map['unregistered_query']
      else
        return nil
      end

      response.respond(&block)
    end
  end
end


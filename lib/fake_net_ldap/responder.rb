module FakeNetLdap

  class Responder #:nodoc:

    def initialize(query, response)
      @query    = query
      @response = response
    end

    def respond(&block)
      case @response
      when Hash
        yield @response
      when Array
        @response.each { |r| yield r }
      when Class
        raise @response.new
      end
    end
  end
end


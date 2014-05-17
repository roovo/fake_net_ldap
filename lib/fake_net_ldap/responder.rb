module FakeNetLdap

  class Responder #:nodoc:

    def initialize(query, response)
      @query    = query
      @response = response
    end

    def respond(&block)
      case @response
      when Hash
        block ? (yield @response) : @response
      when Array
        block ? (@response.each { |r| yield r }) : @response
      when Class
        raise @response.new
      end
    end
  end
end


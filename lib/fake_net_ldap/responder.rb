module FakeNetLdap

  class Responder #:nodoc:

    def initialize(query, response)
      @query    = query
      @response = response
    end
  end
end


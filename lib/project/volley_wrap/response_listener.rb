module VW
  class ResponseListener
    attr_accessor :serializer
    attr_accessor :callback

    def initialize(serializer, &block)
      @serializer = serializer
      @callback = block
    end

    def onResponse(response)
      response_object = expect_json? ? Moran.parse(response.toString) : response.toString
      create_result(response_object, nil)
    end

    def onErrorResponse(error)
      dump_network_error(error)
      create_result(nil, error.toString)
    end

    private

    def expect_json?
      serializer == :json
    end

    def create_result(response_object, error)
      callback.call HTTPResult.new(response_object, error)
    end

    def dump_network_error(error)
      puts error.toString
      if response = error.networkResponse
        puts response.statusCode
        puts response.headers
        puts response.data
      end
    end
  end
end

module VW
  class ResponseListener
    attr_accessor :serializer, :callback, :network_response

    def initialize(serializer, &block)
      @serializer = serializer
      @callback = block
    end

    def onResponse(response)
      response_object = expect_json? ? Moran.parse(response.to_s) : response
      create_result(@network_response, response_object, nil)
    end

    def onErrorResponse(error)
      dump_network_error(error)
      create_result(@network_response, nil, error.toString)
    end

    private

    def expect_json?
      serializer == :json
    end

    def create_result(response, response_object, error)
      request = HTTPResult.new(response, response_object, error)
      if VW::SessionClient.debug
        mp request
      end
      callback.call request
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

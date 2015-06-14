module VW
  class HTTPResult
    attr_accessor :object
    attr_accessor :error
    attr_accessor :response

    def initialize(response, response_object, error)
      @response = response
      @object = response_object
      @error = error
    end

    def status_code
      @response.statusCode if @response
    end

    def not_modified?
      @response.notModified if @response
    end

    def body
      @object.to_s if @object
    end

    def headers
      if @response
        @_headers ||= @response.headers.inject({}){|h, entry_set| h[entry_set[0]] = entry_set[1] ; h }
      end
    end

    def success?
      !failure?
    end

    def failure?
      !!error
    end

    def to_s
      %(

RESULT -------------------------

Status code: #{status_code}
Not modified?: #{not_modified?}
Success: #{success?}

Headers:
#{headers.map{|k,v| "  #{k} = #{v}"}.join("\n")}

Body:
#{body}
\n
)
    end
  end
end


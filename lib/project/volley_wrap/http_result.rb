module VW
  class HTTPResult
    attr_accessor :object, :error, :response, :request_url, :request_params, :request_method

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

    def method_description
      case @request_method
      when 0
        "GET"
      when 1
        "POST"
      when 2
        "PUT"
      when 3
        "DELETE"
      else
        "Unknown"
      end
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

    def inspect
      "<VW::HTTPResult:#{self.object_id} #{@request_url}>"
    end

    def to_s
      header_string = if (h = headers)
        h.map{|k,v| "  #{k} = #{v}"}.join("\n")
      else
        "none"
      end

      params_string = if @request_params
        @request_params.map{|k,v| "  #{k} = #{v}"}.join("\n")
      else
        "none"
      end

      %(

Request -------------------------

URL: #{@request_url}
Method: #{method_description}
Params:
#{params_string}

Response -------------------------

Status code: #{status_code}
Not modified?: #{not_modified?}
Success: #{success?}

Error: #{error.toString if error}

Headers:
#{header_string}

Body:
#{body}
-----------------------------------

)
    end
  end
end


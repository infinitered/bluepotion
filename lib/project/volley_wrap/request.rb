module VW
  class Request < Com::Android::Volley::Toolbox::StringRequest
    # part of this class had to be implemented as a Java extension to work around
    # what appears to be a RM bug. See request.java

    VOLLEY_GET = 0
    VOLLEY_POST = 1
    VOLLEY_PUT = 2
    VOLLEY_DELETE = 3

    def self.get_request(url, listener)
      Request.new(VOLLEY_GET, url, listener, listener).tap do |req|
        req.setRetryPolicy(retry_policy)
      end
    end

    def self.post_request(url, params, listener)
      request_with_params(VOLLEY_POST, url, params, listener)
    end

    def self.put_request(url, params, listener)
      request_with_params(VOLLEY_PUT, url, params, listener)
    end

    def self.delete_request(url, params, listener)
      request_with_params(VOLLEY_DELETE, url, params, listener)
    end

    def self.retry_policy
      Com::Android::Volley::DefaultRetryPolicy.new(10000, 3, 1)
    end

    def headers=(headers)
      # call into the method defined in the .java file
      setHeaders(headers)
    end

    def parseNetworkResponse(network_response)
      # TODO: add an option for a debug mode, which would display all this stuff nicely
      #p network_response.statusCode
      #p network_response.headers
      #p network_response.data
      super
    end

    private

    # this is to maintain compatibility with AFMotion - somewhere (possibly in AFNetworking?) the
    # keys get flattened out like so:
    #
    #     { user: { email: "x@x.com", password: "pass" } }
    # becomes
    #     { "user[email]" => "x@x.com", "user[password]" => "pass" }
    #
    # This is not a robust implementation of this, but will serve our needs for now
    def self.prepare_params(params)
      new_params = {}
      params.keys.each do |key|
        if params[key].is_a?(Hash)
          params[key].keys.each do |inner_key|
            new_params["#{key}[#{inner_key}]"] = params[key][inner_key]
          end
        else
          new_params[key] = params[key]
        end
      end
      new_params
    end

    def self.request_with_params(method, url, params, listener)
      Request.new(method, url, listener, listener).tap do |req|
        req.setParams(prepare_params(params))
        req.setRetryPolicy(retry_policy)
      end
    end

  end

end

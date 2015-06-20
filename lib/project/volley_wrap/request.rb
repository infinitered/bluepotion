module VW
  class Request < Com::Android::Volley::Toolbox::StringRequest
    # part of this class had to be implemented as a Java extension to work around
    # what appears to be a RM bug. See request.java

    VOLLEY_GET = 0
    VOLLEY_POST = 1
    VOLLEY_PUT = 2
    VOLLEY_DELETE = 3

    def self.get_request(url, params, listener)
      url = add_params_to_url(url, params)
      request_with_params(VOLLEY_GET, url, params, listener).tap do |req|
        req.listener = listener
      end
    end

    def self.post_request(url, params, listener)
      request_with_params(VOLLEY_POST, url, params, listener).tap do |req|
        req.listener = listener
      end
    end

    def self.put_request(url, params, listener)
      request_with_params(VOLLEY_PUT, url, params, listener).tap do |req|
        req.listener = listener
      end
    end

    def self.delete_request(url, params, listener)
      request_with_params(VOLLEY_DELETE, url, params, listener).tap do |req|
        req.listener = listener
      end
    end

    def listener=(value)
      @listener = value
    end

    def self.retry_policy
      Com::Android::Volley::DefaultRetryPolicy.new(10000, 3, 1)
    end

    def headers=(headers)
      # call into the method defined in the .java file
      setHeaders(headers)
    end

    def parseNetworkResponse(network_response)
      @listener.network_response = network_response if @listener
      super
    end

    def self.add_params_to_url(url, params)
      if params.blank?
        url
      else
        params_array = params.map do |k, v|
          v = Java::Net::URLEncoder.encode(v, "utf-8")
          "#{k}=#{v}"
        end
        "#{url}?#{params_array.join("&")}"
      end
    end

    def self.set_request_for_listener(method, url, params, listener)
      # There probably is a much better way then passing all these around like this
      listener.request_url = url
      listener.request_params = params
      listener.request_method = method
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
            new_params["#{key}[#{inner_key}]"] = params[key][inner_key].to_s
          end
        else
          new_params[key.to_s] = params[key].to_s
        end
      end
      new_params
    end


    def self.request_with_params(method, url, params, listener)
      set_request_for_listener method, url, params, listener

      Request.new(method, url, listener, listener).tap do |req|
        req.setRetryPolicy(retry_policy)
        unless method == VOLLEY_GET
          params = prepare_params(params)
          req.setParams(params)
        end
      end
    end

  end

end

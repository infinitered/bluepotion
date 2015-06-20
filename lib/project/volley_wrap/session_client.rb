module VW
  class SessionClient
    attr_accessor :context
    attr_accessor :base_url
    attr_accessor :headers
    attr_accessor :serializer

    class << self
      attr_accessor :shared
      attr_accessor :debug

      def build_shared(context, url, &block)
        self.shared = SessionClient.new(context, url)
        self.shared.instance_eval(&block) if block
      end
    end

    def initialize(context, base_url)
      @context = context
      @base_url = base_url
      @headers = {}
    end

    def header(name, value)
      headers[name] = value
    end

    def response_serializer(serializer)
      @serializer = serializer
    end

    def get(url, params, opts={}, &block)
      request_url = base_url + url
      ser = opts[:serializer] || @serializer
      listener = VW::ResponseListener.new(ser, &block)
      queue VW::Request.get_request(request_url, params, listener)
    end

    def post(url, params, opts={}, &block)
      request_url = base_url + url
      ser = opts[:serializer] || @serializer
      listener = VW::ResponseListener.new(serializer, &block)
      queue VW::Request.post_request(request_url, params, listener)
    end

    def put(url, params, opts={}, &block)
      request_url = base_url + url
      ser = opts[:serializer] || @serializer
      listener = VW::ResponseListener.new(nil, &block)
      queue VW::Request.put_request(request_url, params, listener)
    end

    def delete(url, params, opts={}, &block)
      request_url = base_url + url
      ser = opts[:serializer] || @serializer
      listener = VW::ResponseListener.new(nil, &block)
      queue VW::Request.delete_request(request_url, params, listener)
    end

    private

    def queue(request)
      request.headers = headers
      request_queue.add(request)
    end

    def request_queue
      @request_queue ||= Com::Android::Volley::Toolbox::Volley.newRequestQueue(context)
    end

  end
end

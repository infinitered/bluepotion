# Nice wrapper around VolleyWrapper, to use in BluePotion.
#
# result that is returned has these attributes:
#   response
#   object
#   body
#   status_code
#   headers
#   not_modified?
#   success?
#   failure?
#
# @example
#   # Create a session and do a single HTML get. It's better
#   # to use the shared session below.
#   app.net.get("http://google.com") do |response|
#     mp response.object # <- HTML
#   end
#
#   # To initialize the shared session, which is best to use
#   # rather than the one-off above, do this. Once this
#   # is done, all your gets, posts, puts, etc will use this
#   # share session
#   app.net.build_shared("http://baseurl.com") do |shared|
#     # You can override the serializer per request
#     # Leave blank for string
#     shared.serializer = :json
#   end
#
#   # For shared, use relative paths
#   app.net.get("foo.html") do |response|
#     mp response.object # <- returns type you set in shared.serializer
#   end
#
#   # Post
#   app.net.post("foo/bar", your_params_hash) do |response|
#     mp response.object # <- returns type you set in shared.serializer
#   end
#
#   # If you have built a shared session, but want to use another
#   # session, do this:
#   app.net.get("foo.html", session: app.net.single_use_session) do |response|
#     mp response.object # <- returns type you set in shared.serializer
#   end
#
#   # Get json:
#   url = "http://openweathermap.org/data/2.1/find/name?q=san%20francisco"
#   app.net.get_json(url) do |request|
#     # request.object is a hash, parsed from the json
#     temp_kelvin = request.object["list"].first["main"]["temp"]
#   end
class BluePotionNet
  class << self
    def session_client
      @_session_client ||= VW::SessionClient
    end

    def session
      session_client.shared ? session_client.shared : single_use_session
    end

    def is_shared?
      !session_client.shared.is_nil?
    end

    def single_use_session
      session_client.new(PMApplication.current_application.context, "")
    end

    def build_shared(url, &block)
      session_client.build_shared(PMApplication.current_application.context, url, &block)
    end

    def get(url, params={}, opts={}, &block)
      raise "[BluePotion error] You must provide a block when using app.net.get" unless block
      ses = opts.delete(:session) || self.session
      ses.get(url, params, opts, &block)
    end

    def get_json(url, params={}, opts={}, &block)
      raise "[BluePotion error] You must provide a block when using app.net.get_json" unless block
      ses = opts.delete(:session) || self.session
      opts[:serializer] = :json
      ses.get(url, params, opts, &block)
    end

    def post(url, params, opts={}, &block)
      raise "[BluePotion error] You must provide a block when using app.net.post" unless block
      ses = opts.delete(:session) || self.session
      ses.post(url, params, opts, &block)
    end

    def put(url, params, opts={}, &block)
      raise "[BluePotion error] You must provide a block when using app.net.put" unless block
      ses = opts.delete(:session) || self.session
      ses.put(url, params, opts, &block)
    end

    def delete(url, params, opts={}, &block)
      raise "[BluePotion error] You must provide a block when using app.net.delete" unless block
      ses = opts.delete(:session) || self.session
      ses.delete(url, params, opts, &block)
    end
  end
end

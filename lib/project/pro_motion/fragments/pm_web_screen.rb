class PMWebScreen < Android::Webkit::WebViewFragment
  include PMScreenModule

  #def onCreate(bundle); super; on_create(bundle); end
  def on_create(bundle)

    # Defaults
    opts = {
      url: nil,
      save_password: true,
      save_form_data: true,
      javascript: true,
      zoomable: false,
      custom_client: nil,
      cookies: true
    }#.merge(options)

    # Apply settings
    settings = web.settings
    settings.savePassword = opts[:save_password]
    settings.saveFormData = opts[:save_form_data]
    settings.javaScriptEnabled = opts[:javascript]
    settings.supportZoom = opts[:zoomable]
    web.setWebViewClient(opts[:custom_client]) if opts[:custom_client]
    web.loadUrl(opts[:url]) if opts[:url]

    accept_cookies if opts[:cookies]

  end

  def accept_cookies
    cookie_manager = Android::Webkit::CookieManager.getInstance()
    cookie_manager.setAcceptCookie(true)
  end

  def web
    self.webView
  end

  def url=(url_str)
    self.webView.loadUrl(url_str)
  end

end
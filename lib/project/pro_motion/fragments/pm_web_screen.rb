# Finding it more and more easy to just derive from PMScreen
class PMWebScreen < PMScreen
  attr_accessor :webview, :back_for_webview
  ACTION_DOWN = Android::View::KeyEvent::ACTION_DOWN
  KEYCODE_BACK = Android::View::KeyEvent::KEYCODE_BACK

  # def screen_setup
  #   web_view_setup
  # end

  def add_web_view
    # SPECIAL NOTE: Must create from activity, not from context (breaks dialogs)
    @webview = Android::Webkit::WebView.new(find.activity)
    append(@webview)
    settings = @webview.settings
    settings.savePassword = true
    settings.saveFormData = true
    settings.javaScriptEnabled = true
    settings.supportZoom = false

    # Make the back button the device go back a screen on the webview
    @back_for_webview = true

    # By default some URLs try to launch a browser. Very unlikely that this is
    # the behaviour we'll want in an app.   So we use this to stop
    @webview.webViewClient = PMWebClient.new

    accept_cookies

    @webview
  end

  # swallow back presses and goback on web
  def on_key_down(key_code, event)
    call_super = true
    if (event.action == ACTION_DOWN) && key_code == KEYCODE_BACK
      if @webview.canGoBack && @back_for_webview
        @webview.goBack
        call_super = false
      end
    end

    call_super
  end


  def open_url(url)
    add_web_view
    @webview.loadUrl(url)
  end

  def accept_cookies(accept_cookies=true)
    cookie_manager = Android::Webkit::CookieManager.getInstance()
    cookie_manager.acceptCookie = accept_cookies
  end

  def web
    self.webView
  end

  def url=(url_str)
    self.webView.loadUrl(url_str)
  end

end

class PMWebClient < Android::Webkit::WebViewClient
  ACTION_VIEW = "android.intent.action.VIEW"

  def shouldOverrideUrlLoading(view, url)

    if url.startsWith("tel:")
      app.launch(tel: url)
    elsif url.startsWith("https://www.google.com/maps")
      app.launch(map: url)
    else
      view.loadUrl(url) if view
    end

    true # when return true, stop loading URL from happening
  end

end
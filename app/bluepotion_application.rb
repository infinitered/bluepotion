class BluePotionApplication < PMApplication

  home_screen HomeScreen
  # You can also do something like this:
  #   def home_screen_class
  #     User.current.logged_in? ? WelcomeScreen : LoginScreen
  #   end

  def on_create
    RMQ.debugging = true
    mp "BluePotionApplication on_create", debugging_only: true

    VW::SessionClient.debug = true # Debug network calls
  end
end

class BluePotionApplication < PMApplication

  home_screen HomeScreen

  def on_create
    mp "BluePotionApplication on_create", debugging_only: true
  end
end

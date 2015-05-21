class ApplicationStylesheet < RMQStylesheet

  def application_setup
    font_family = "sans-serif"
    font.add_named :xlarge,         font_family, 40, :normal
    font.add_named :large,          font_family, 30, :normal
    font.add_named :medium,         font_family, 24, :normal
    font.add_named :medium_bold,    font_family, 24, :bold
    font.add_named :small,          font_family, 18, :normal
    font.add_named :tiny,           font_family, 14, :normal

    color.add_named :potion_blue, "#3759FE"
  end

end

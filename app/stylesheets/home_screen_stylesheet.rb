class HomeScreenStylesheet < ApplicationStylesheet

  def root_view(st)
    #st.layout_width = :match_parent
    #st.layout_height = :match_parent
    #st.gravity = :center
  end

  def text_view(st)
    standard_text_view(st)
    st.font = font.large
    st.color = color.potion_blue
  end

  def button(st)
    standard_button(st)
    st.background_color = color.yellow
    st.color = color.black
    st.text = "Click me"
  end
end

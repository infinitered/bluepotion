class HomeScreenStylesheet < ApplicationStylesheet

  def root_view(st)
    st.layout_width = :match_parent
    st.layout_height = :match_parent
    #st.orientation = :vertical
    st.gravity = :center
  end

  def text_view(st)
    st.layout_width = :wrap_content
    st.layout_height = :wrap_content
    st.margin_bottom = 12
    st.text_color = color.potion_blue
    st.text_size = 40
  end

  def button(st)
    st.layout_width = :wrap_content
    st.layout_height = :wrap_content
    st.padding_left = st.padding_right = 12
    st.background_color = color.potion_blue
    st.text_color = Potion::Color::WHITE
    st.text = "Click me"
  end
end

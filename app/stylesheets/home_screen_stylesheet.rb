class HomeScreenStylesheet < ApplicationStylesheet

  def root_view(st)
    st.layout_width = :full
    st.layout_height = :full
    st.gravity = :center
  end

  def hello_label(st)
    standard_text_view(st)
    st.font = font.large
    st.color = color.potion_blue
  end

  def logo(st)
    st.image = image.resource("bluepotion_logo")
  end

  def drink_button(st)
    standard_button(st)
    st.background_color = color.mustard
    st.color = color.black
    st.text = "Drink"
  end

  def open_example_table_button(st)
    standard_button(st)
    st.background_color = color.potion_blue
    st.color = color.white
    st.text = "Open table screen"
  end

end

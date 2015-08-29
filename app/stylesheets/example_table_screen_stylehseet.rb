class ExampleTableScreenStylesheet < ApplicationStylesheet

  def root_view(st)
    st.layout_width = :full
    st.layout_height = :full
    st.gravity = :center
    st.background_color = color.white
  end

end

class ExampleTableScreenStylesheet < ApplicationStylesheet

  def root_view(st)
    st.layout_width = :full
    st.layout_height = :full
    st.gravity = :center
  end

  def hello_label(st)
    standard_text_view st
    st.text = "Table goes here"
  end

end

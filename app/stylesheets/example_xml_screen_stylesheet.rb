class ExampleXmlScreenStylesheet < ApplicationStylesheet
  # Add your view stylesheets here. You can then override styles if needed,
  # example: include FooStylesheet

  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def root_view(st)
    st.layout_width = :full
    st.layout_height = :full
    st.gravity = :center
  end

  def hello_label(st)
    st.layout_width = :wrap_content
    st.layout_height = :wrap_content
    st.margin_bottom = 12
    st.font = font.large
    st.color = color.black
    st.text = "Hello"
  end
end

class HomeScreenStylesheet < ApplicationStylesheet

  def root_view(st)
    st.layout = :full
    st.padding = 20
    st.orientation = :vertical
    st.background_color = color.white
  end

  def logo(st)
    st.layout = {t: 0, w: 100, h: 100, centered: :horizontal}
    st.image = image.resource("bluepotion_logo")
    #st.layout_center_horizontal = true
  end

  def hello_label(st)
    standard_text_view(st)
    st.font = font.large
    st.color = color.potion_blue
  end

  def drink_button(st)
    #st.layout = {t: 10, l: 40, fr: 40, fb: 10}
    standard_button(st)
    st.background_color = color.mustard
    st.color = color.black
    st.text = "Weather in SF"
  end

  def dialog_button(st)
    #st.layout = {t: 10, l: 40, fr: 40, fb: 10}
    standard_button(st)
    st.background_color = color.nice_blue
    st.color = color.black
    st.text = "Open Dialog"
  end

  def xml_button(st)
    standard_button(st)
    st.background_color = color.nice_blue
    st.color = color.black
    st.text = "Open XML Screen"
  end

  def open_example_table_button(st)
    standard_button(st)
    st.background_color = color.potion_blue
    st.color = color.white
    st.text = "Open table screen"
  end

  def countdown_button(st)
    standard_button(st)
    st.background_color = color.light_blue
    st.color = color.black
    st.text = "Run Countdown"
  end

  def calendar(st)
    st.layout = {w: :full, h: 400}
    st.background_color = color.black
  end

end

__END__


    <Button
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="New Button"
        android:id="@+id/button"
        android:layout_below="@+id/imageView"
        android:layout_alignParentLeft="false"
        android:layout_alignParentStart="false"
        android:layout_alignParentEnd="false"
        android:layout_marginTop="20dp"
        android:layout_marginLeft="20dp" />

    <ImageView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:id="@+id/imageView"
        android:src="@mipmap/ic_launcher"
        android:layout_alignParentTop="false"
        android:layout_marginTop="20dp"
        android:layout_alignParentEnd="false"
        android:layout_centerHorizontal="true" />

    <Button
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="New Button"
        android:id="@+id/button2"
        android:layout_below="@+id/button"
        android:layout_alignLeft="@+id/button"
        android:layout_alignStart="@+id/button"
        android:layout_marginTop="10dp" />


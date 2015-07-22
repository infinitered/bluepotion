class ImageCell < Android::Widget::FrameLayout

  def on_load
    inflater = app.find.activity.layoutInflater
    @row = inflater.inflate(R::Layout::Image_cell, nil, true)

    rmq.append!(@row)
  end

  def custom_name=(dev_name)
    find(@row).find(Potion::Label).data = dev_name
  end

  def color=(new_color)
    find(@row).style do |st|
      st.background_color = new_color
    end
  end


end
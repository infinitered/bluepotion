class ImageCell < Android::Widget::FrameLayout

  def on_load
    inflater = app.find.activity.layoutInflater
    @row = inflater.inflate(R::Layout::Image_cell, nil, true)

    rmq.append!(@row)
  end

  def dev_name=(dev_name)
    find(@row).find(Potion::Label).data = dev_name
  end


end
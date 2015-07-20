class ImageCell < Android::Widget::FrameLayout

  def initialize app
    mp "Woah ImageCell initialized"
  #   inflater = app.find.activity.layoutInflater
  #   row = inflater.inflate(R::Layout::Image_cell, nil, true)
  #   rmq.append!(row)
  end

  def on_load
    mp "on_load called in ImageCell"
    @test = find.append(Potion::Label)

    #@price = rmq.append(UILabel, :price_text_style)
    #rmq.all.reapply_styles
  end

  #def price= per_pound_price
  #  @price.data = per_pound_price
  #end
end
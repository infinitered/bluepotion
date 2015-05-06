class StylersLinearLayoutStyler < StylersViewStyler

  def weight_sum=(weight_sum)
    view.setWeightSum weight_sum
  end
  alias_method :weightSum=, :weight_sum=

  def orientation=(orientation)
    view.setOrientation convert_orientation(orientation)
  end

  def gravity=(gravity)
    view.gravity = convert_gravity(gravity)
  end

  def finalize
    view.setLayoutParams(layout_params)
  end

  private

  def convert_orientation(orientation)
    return Android::Widget::LinearLayout::HORIZONTAL if orientation == :horizontal
    return Android::Widget::LinearLayout::VERTICAL   if orientation == :vertical
    orientation
  end

end

class RMQLinearLayoutStyler < RMQViewStyler

  def weight_sum=(weight_sum)
    @view.setWeightSum weight_sum
  end

  def orientation=(orientation)
    @view.setOrientation convert_orientation(orientation)
  end

  def gravity=(gravity)
    @view.gravity = convert_gravity(gravity)
  end

  def finalize
    @view.setLayoutParams(layout_params)
  end

  private

  def convert_orientation(orientation)
    case orientation
    when :horizontal
      Potion::LinearLayout::HORIZONTAL
    when :vertical
      Potion::LinearLayout::VERTICAL
    else
      orientation
    end
  end

end

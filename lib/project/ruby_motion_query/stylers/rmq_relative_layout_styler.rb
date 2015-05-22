class RMQRelativeLayoutStyler < RMQViewStyler

  def finalize
    @view.setLayoutParams(layout_params)
  end

end

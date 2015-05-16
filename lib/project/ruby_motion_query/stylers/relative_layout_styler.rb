class StylersRelativeLayoutStyler < StylersViewStyler

  def finalize
    view.setLayoutParams(layout_params)
  end

end

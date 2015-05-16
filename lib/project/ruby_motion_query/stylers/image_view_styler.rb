class StylersImageViewStyler < StylersViewStyler

  def image_resource=(resource_id)
    view.imageResource = resource_id
  end
  alias_method :image=, :image_resource=
  alias_method :imageResource=, :image_resource=

  def adjust_view_bounds=(adjust_view_bounds)
    view.adjustViewBounds = adjust_view_bounds
  end
  alias_method :adjustViewBounds=, :adjust_view_bounds=

  def max_height=(max_height)
    view.maxHeight = dp2px(max_height)
  end
  alias_method :maxHeight=, :max_height=

  def max_width=(max_width)
    view.maxWidth = dp2px(max_width)
  end
  alias_method :maxWidth=, :max_width=

  def tint=(t)
    view.setColorFilter(convert_color(t))
  end

end

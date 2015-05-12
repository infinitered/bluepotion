class RMQ
  def add_subview(subview, style_name)
    #subview.setId(Potion::ViewIdGenerator.generate)
    #view.addView(subview)
    #if stylesheet
      #apply_style_to_view(subview, style_name)
    #end
    #RMQ.new(subview, stylesheet, context)
  end

  def append(view_or_class, style=nil, opts={})
    add_subview(view_or_class.new(context), style)
  end

  def append!(view_or_class, style=nil, opts={})
    append(view_or_class, style, opts).get
  end

  def create(view_or_class, style=nil, opts={})
  end

  def create!(view_or_class, style=nil, opts={})
  end

  def build(view_or_class, style=nil, opts={})
  end

  def build!(view_or_class, style=nil, opts={})
  end
end

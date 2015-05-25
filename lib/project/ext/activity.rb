class Android::App::Activity

  def root_view
    @_root_view ||= getWindow.getDecorView.findViewById(Android::R::Id::Content)
  end

  def rmq_data
    @_rmq_data ||= RMQActivityData.new
  end

  def rmq(*working_selectors)
    crmq = (rmq_data.cached_rmq ||= RMQ.create_with_selectors([], self))

    if working_selectors.length == 0
      crmq
    else
      RMQ.create_with_selectors(working_selectors, self, crmq)
    end
  end

  def stylesheet
    self.rmq.stylesheet
  end

  def stylesheet=(value)
    self.rmq.stylesheet = value
  end

  def color(*params)
    RMQ.color(*params)
  end

  def font
    rmq.font
  end

  def image
    rmq.image
  end

  def append(view_or_class, style=nil, opts={}, dummy=nil)
    self.rmq.append(view_or_class, style, opts)
  end

  def append!(view_or_class, style=nil, opts={})
    self.rmq.append(view_or_class, style, opts).get
  end

  class << self

    def stylesheet(style_sheet_class)
      @rmq_style_sheet_class = style_sheet_class
    end

    def rmq_style_sheet_class
      @rmq_style_sheet_class
    end

  end


end

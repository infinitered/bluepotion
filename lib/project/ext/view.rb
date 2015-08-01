class Android::View::View
  def inspect
    "<#{id} #{short_class_name}>"
  end

  def to_s
    self.inspect
  end

  def resource_entry_name
    if self.id > 0
      resources.getResourceEntryName(self.id)
    end
  end

  def rmq_data
    @_rmq_data ||= RMQViewData.new
  end

  def rmq_created
  end

  # Override this to build your view and view's subviews
  def rmq_build
    on_load
  end
  def on_load
  end

  def rmq_appended
  end

  def rmq_style_applied
    on_styled
  end

  def on_styled
  end

    #def rmq(*working_selectors)
      #crmq = (rmq_data.cached_rmq ||= RMQ.create_with_selectors([], self))

      #if working_selectors.length == 0
        #crmq
      #else
        #RMQ.create_with_selectors(working_selectors, self, crmq)
      #end
    #end

  def find(*working_selectors) # Not calling rmq below for performance reasons (one less method invocation)
    RMQ.create_with_selectors(working_selectors, self)
  end
  def rmq(*working_selectors)
    RMQ.create_with_selectors(working_selectors, self)
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

  def subviews
    # TODO, see if anyone uses this, and remove
    out = []

    if self.is_a?(Potion::ViewGroup)
      (0...self.getChildCount).each_with_index do |i|
        sbv = self.getChildAt(i)
        out << sbv unless self == sbv
      end
    end

    out
  end

  def superview
    sv = self.getParent()
    sv = nil unless sv.is_a?(Potion::ViewGroup)
    sv
  end
end

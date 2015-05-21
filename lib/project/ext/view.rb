class Android::View::View
  def inspect
    "<#{id} #{short_class_name}>"
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

  def rmq(*working_selectors)
    q = RMQ.create_with_selectors(working_selectors, self) #.tap do |o|
    q
      #if vc = self.rmq_data.view_controller
        #o.weak_view_controller = vc
      #end
    #end
  end

  def color
    rmq.color
  end

  def font
    rmq.font
  end

  def image
    rmq.image
  end

  def subviews
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

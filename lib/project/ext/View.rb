class Android::View::View
  def rmq_data
    @_rmq_data ||= RMQViewData.new
  end

  def rmq_created
  end

  # Override this to build your view and view's subviews
  def rmq_build
  end

  def rmq_appended
  end

  def rmq_style_applied
  end

  def rmq(*working_selectors)
    RMQ.create_with_selectors(working_selectors, self) #.tap do |o|
      #if vc = self.rmq_data.view_controller
        #o.weak_view_controller = vc
      #end
    #end
  end

  def subviews
    out = []
    (0...self.getChildCount).each_with_index do |i|
      out << self.getChildAt(i)
    end
    out
  end
end

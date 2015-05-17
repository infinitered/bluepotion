class Android::App::Activity

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
  alias :find :rmq

  def root_view
    getWindow.getDecorView.findViewById(Android::R::Id::Content)
    #findViewById(Android::R::Id.PageLayout)
  end

end

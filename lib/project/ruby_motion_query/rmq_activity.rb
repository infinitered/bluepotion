class RMQActivity < Android::App::Activity
  def rmq(*working_selectors)
    crmq = RMQ.create_with_selectors([], self) # TODO

    if working_selectors.length == 0
      crmq
    else
      RMQ.create_with_selectors(working_selectors, self, crmq)
    end
  end
end

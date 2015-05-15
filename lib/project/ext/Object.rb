class Object
  def id
    0
  end

  def object_id
    id
  end

  def rmq(*working_selectors)
    if (app = RMQ.app) && (window = app.window) && (cvc = app.current_activity)
      cvc.rmq(working_selectors)
    else
      RMQ.create_with_array_and_selectors([], working_selectors, self)
    end
  end

  def mp(s)
    puts(s)
  end
end

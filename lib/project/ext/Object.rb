class Object
  def rmq(*working_selectors)
    if (app = RMQ.app) && (window = app.window) && (cvc = app.current_activity)
      cvc.rmq(working_selectors)
    else
      RMQ.create_with_array_and_selectors([], working_selectors, self)
    end
  end

  # REMOVE when mp starts working
  def mp(s)
    puts(s)
  end

  # REMOVE when RubyMotion adds this
  def id
    0
  end

  # REMOVE when RubyMotion adds this
  def object_id
    id
  end
end

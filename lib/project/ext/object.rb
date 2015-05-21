class Object

  # REMOVE when RubyMotion adds this
  def object_id
    Java::Lang::System.identityHashCode(self)
  end

  # REMOVE when RubyMotion adds this
  def caller
    "caller NOT IMPLEMENTED"
  end

  def inspect
    if self.respond_to?(:id)
      "<#{short_class_name}|#{id}>"
    else
      "<#{short_class_name}|#{object_id}>"
    end
  end

  def short_class_name
    self.class.name.split('.').last
  end


  # RMQ stuff

  def rmq(*working_selectors)
    if (app = RMQ.app) && ((cvc = app.current_screen) || (cvc = app.current_activity))
      cvc.rmq(working_selectors)
    else
      RMQ.create_with_array_and_selectors([], working_selectors, self)
    end
  end

  def find(*args) # Do not alias this, strange bugs happen where classes don't have methods
    rmq(*args)
  end

  def find!(*args) # Do not alias this, strange bugs happen where classes don't have methods
    rmq(*args).get
  end

  # BluePotion stuff

  # REMOVE when mp starts working
  def mp(s)
    if s.nil?
      s = "<nil>"
    else
      s = s.to_s
    end
    backspace = "\b\b " * (Android::App::Application.name.length + 13)
    lines = s.split("\n")
    lines.each do |line|
      puts "#{backspace}\e[1;#{34}m#{line}\e[0m"
    end
  end

  def app
    rmq.app
  end

  def device
    rmq.device
  end


end

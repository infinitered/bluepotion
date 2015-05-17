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
    backspace = "\b\b " * (Android::App::Application.name.length + 13)
    lines = s.split("\n")
    lines.each do |line|
      puts "#{backspace}\e[1;#{34}m#{line}\e[0m"
    end
  end

  # REMOVE when RubyMotion adds this
  def object_id
    Java::Lang::System.identityHashCode(self)
  end

  def inspect
    "<#{short_class_name}:#{object_id}>"
  end

  def short_class_name
    self.class.name.split('.').last
  end
end

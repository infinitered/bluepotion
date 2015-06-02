class Object
  # REMOVE when RubyMotion adds this
  def object_id
    Java::Lang::System.identityHashCode(self)
  end

  # REMOVE when RubyMotion adds this
  def caller
    out = "caller:"

    stacktrace = Java::Lang::Thread.currentThread.getStackTrace
    stacktrace.each_with_index do |trc, i|
      klass_name = trc.className
      method_name = trc.methodName

      next if klass_name == "com.rubymotion.ReplTask"
      next if method_name == "getStackTrace" || method_name == "getThreadStackTrace"

      line_number = trc.getLineNumber
      out << "\n  "
      #out << " " * i
      if line_number < 0
        out << "    "
      else
        out << line_number.to_s.ljust(4)
      end
      out << " "
      out << method_name.to_s.ljust(30)
      out << " "
      out << klass_name.to_s
    end

    out
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

  def open(screen_class, options={})
    rmq.screen.open(screen_class, options) if rmq.screen
  end

  # BluePotion stuff

  # REMOVE when mp starts working
  def mp(s, opts={})
    if opts[:debugging_only]
      return unless RMQ.debugging?
    end

    if s.nil?
      s = "<nil>"
    else
      s = s.to_s
    end
    backspace = "\b\b " * (Android::App::Application.name.length + 20)
    lines = s.split("\n")
    lines.each do |line|
      if RMQ.debugging?
        out = backspace
        out << "\e[1;#{36}m#{self.object_id}\e[0m #{self.short_class_name}".ljust(50)
        out << "  \e[1;#{34}m#{line}\e[0m"
        puts out
      else
        puts "#{backspace} \e[1;#{34}m#{line}\e[0m"
      end
    end
  end

  def app
    rmq.app
  end

  def device
    rmq.device
  end


end

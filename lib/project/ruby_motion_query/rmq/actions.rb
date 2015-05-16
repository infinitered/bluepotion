class RMQ

  # @return [RMQ]
  def attr(new_settings)
    selected.each do |view|
      new_settings.each do |k,v|
        view.send "#{k}=", v
      end
    end
    self
  end

  def send(method, args = nil)
    selected.each do |view|
      if view.respond_to?(method)
        if args
          view.__send__ method, args
        else
          view.__send__ method
        end
      end
    end
    self
  end

end

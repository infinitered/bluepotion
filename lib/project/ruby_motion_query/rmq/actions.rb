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

  def focus
    unless RMQ.is_blank?(selected)
      selected.last.requestFocus
    end
    self
  end

  def hide
    selected.each { |view| view.setVisibility(Potion::View::INVISIBLE) }
    self
  end

  def show
    selected.each { |view| view.setVisibility(Potion::View::VISIBLE) }
    self
  end

  def cleanup
    selected.each { |view| view.cleanup }
    self
  end

  def clear_cache
    selected.each { |view| view.rmq_data.clear_query_cache }
    self
  end

  #def toggle
    #selected.each { |view| view.hidden = !view.hidden? }
    #self
  #end

end

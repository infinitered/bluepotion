class RMQ
  def on(event, args={}, &block)
    self.selected.each do |view|
      case event
      when :click, :tap, :touch
        handle_click view
      when :change
        handle_change view
      else
        raise "[RMQ ERROR] Unrecognized event: #{event}"
      end
    end

  end

  private

  def handle_click view
    # Click event for ListItems
    if view.respond_to? :setOnItemClickListener
      view.onItemClickListener = RMQItemClick.new(&block)
    # Generic Click
    else
      view.onClickListener = RMQClick.new(&block)
    end
  end


  def handle_change view
    # Seek bar change
    if view.respond_to? :setOnSeekBarChangeListener
      view.onSeekBarChangeListener = RMQSeekChange.new(args, &block)
    # Text change
    elsif view.respond_to? :addTextChangeListener
      view.addTextChangedListener(RMQTextChange.new(&block))
    end
  end

end




class RMQ
  def on(event, args={}, &block)
    self.selected.each do |view|
      case event
      when :click, :tap, :touch
        handle_click(view, &block)
      when :change
        handle_change(view, args, &block)
      when :done
        handle_done(view, &block)
      when :focus
        handle_focus(view, &block)
      else
        raise "[RMQ ERROR] Unrecognized event: #{event}"
      end
    end

  end

  private

  def handle_click(view, &block)
    # Click event for ListItems
    if view.respond_to? :setOnItemClickListener
      view.onItemClickListener = RMQItemClick.new(&block)
    # Generic Click
    else
      view.onClickListener = RMQClick.new(&block)
    end
  end

  def handle_change(view, args, &block)
    # Seek bar change
    if view.respond_to? :setOnSeekBarChangeListener
      view.onSeekBarChangeListener = RMQSeekChange.new(args, &block)
    elsif view.respond_to? :setOnCheckedChangeListener
      view.onCheckedChangeListener = RMQCheckedChange.new(&block)
    elsif view.respond_to? :setOnItemSelectedListener
      view.onItemSelectedListener = RMQSelectChange.new(&block)
    # Text change
    elsif view.respond_to? :addTextChangedListener
      view.addTextChangedListener(RMQTextChange.new(&block))
    elsif view.respond_to? :setOnValueChangedListener
      view.onValueChangedListener = RMQNumberPickerChange.new(&block)
    end
  end

  def handle_done(view, &block)
    # Keyboard done button pressed
    if view.respond_to? :setOnEditorActionListener
      view.onEditorActionListener = RMQKeyboardAction.new(&block)
    end
  end

  def handle_focus(view, &block)
    if view.respond_to? :setOnFocusChangeListener
      view.onFocusChangeListener = RMQFocusListener.new(&block)
    end
  end
end




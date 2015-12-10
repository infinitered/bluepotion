class RMQFocusListener

  def initialize(&block)
    @callback = block
  end

  def onFocusChange(v, has_focus)
    @callback.call(has_focus) if @callback
  end
end
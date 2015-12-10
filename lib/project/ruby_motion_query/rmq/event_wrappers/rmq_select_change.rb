class RMQSelectChange
  def initialize(&block)
    @done_callback = block
  end

  def onItemSelected(parent, view, pos, id)
    @done_callback.call(pos) if @done_callback
  end

  def onNothingSelected(view)
    @done_callback.call(nil) if @done_callback
  end
end
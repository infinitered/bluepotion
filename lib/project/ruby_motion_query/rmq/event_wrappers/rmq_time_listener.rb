class RMQTimeListener

  def initialize(&block)
    @block = block
  end

  def onTimeSet(view,  hour_of_day, minute)
    @block.call(hour_of_day, minute) if @block
  end
end
class RMQClickBase
  attr_accessor :click_block

  def initialize(&block)
    @click_block = block
  end
end

class RMQClick < RMQClickBase

  def onClick(view)
    click_block.call(view)
  end

end

class RMQItemClick < RMQClickBase

  def onItemClick(parent, view, position, id)
    click_block.call(parent, view, position, id)
  end

end
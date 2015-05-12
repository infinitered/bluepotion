class RMQ
  def on(event, args={}, &block)
    case event
    when :click, :tap, :touch
      view.onClickListener = ClickHandler.new(&block)
    else
      raise "Unrecognized event: #{event}"
    end
  end
end

class ClickHandler
  attr_accessor :click_block

  def initialize(&block)
    @click_block = block
  end

  def onClick(view)
    click_block.call(view)
  end

end

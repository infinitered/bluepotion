class RMQ
  def on(event, args={}, &block)
    self.selected.each do |view|

      case event
      when :click, :tap, :touch
        view.onClickListener = RMQClickHandler.new(&block)
      else
        raise "[RMQ ERROR] Unrecognized event: #{event}"
      end

    end

  end
end

class RMQClickHandler
  attr_accessor :click_block

  def initialize(&block)
    @click_block = block
  end

  def onClick(view)
    click_block.call(view)
  end

end

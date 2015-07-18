module DelayedExecution

  def self.after(delay, &block)
    Potion::Handler.new.postDelayed(BlockRunnable.new(&block), delay * 1000.0)
  end

  class BlockRunnable
    def initialize(&block)
      @block = block
    end

    def run
      @block.call
    end
  end
end

class RMQSeekChange
  attr_accessor :change_block

  def initialize(action=:change, &block)
    @action = action
    # Empty hash from RMQ Events means we keep our default
    @action = :change if @action == {}
    @change_block = block
  end

  def onStopTrackingTouch(seek_bar)
    @change_block.call(seek_bar) if @action == :stop
  end

  def onStartTrackingTouch(seek_bar)
    @change_block.call(seek_bar) if @action == :start
  end

  def onProgressChanged(seek_bar, progress, from_user)
    @change_block.call(seek_bar, progress, from_user) if @action == :change
  end

end
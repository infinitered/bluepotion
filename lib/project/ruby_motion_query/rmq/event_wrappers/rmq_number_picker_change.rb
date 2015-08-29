class RMQNumberPickerChange
  attr_accessor :change_block

  def initialize(&block)
    @change_block = block
  end

  def onValueChange(picker, old_val, new_val)
    @change_block.call(picker, old_val, new_val)
  end

end
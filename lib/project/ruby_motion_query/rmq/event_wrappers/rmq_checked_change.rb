class RMQCheckedChange

  def initialize(&block)
    @callback = block
  end

  # If used by a RadioGroup, the second parameter will be the id of
  # the selected RadioButton.
  # If used by a RadioButton or a Checkbox, it will be a boolean
  def onCheckedChanged(_, checked_or_id)
    @callback.call(checked_or_id) if @callback
  end

end
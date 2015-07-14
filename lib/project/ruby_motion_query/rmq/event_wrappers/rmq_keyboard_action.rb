class RMQKeyboardAction
  def initialize(&block)
    @done_callback = block
  end

  def onEditorAction(view, action_id, key_event)
    if action_id == Potion::EditorInfo::IME_ACTION_DONE
      @done_callback.call if @done_callback
    end
    false
  end
end
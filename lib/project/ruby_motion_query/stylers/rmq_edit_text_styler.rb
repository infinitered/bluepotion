class RMQEditTextStyler < RMQViewStyler

  def hint=(text)
    @view.hint = text
  end

  def text=(text)
    @view.text = text
  end

end

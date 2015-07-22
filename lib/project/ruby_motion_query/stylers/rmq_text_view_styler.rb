class RMQTextViewStyler < RMQViewStyler
  def text_size=(text_size)
    @view.textSize = text_size
  end

  def font_family=(font_family)
    @font_family = font_family
  end

  def text_style=(text_style)
    @text_style =
      case text_style.to_s.downcase
      when "bold"
        Android::Graphics::Typeface::BOLD
      when "italic"
        Android::Graphics::Typeface::ITALIC
      when "bold italic"
        Android::Graphics::Typeface::BOLD_ITALIC
      when "normal"
        Android::Graphics::Typeface::NORMAL
      end
  end

  def text_color=(text_color)
    @view.textColor = convert_color(text_color)
  end
  def color=(text_color)
    @view.textColor = convert_color(text_color)
  end

  def text=(text)
    @view.text = text
  end

  def font=(rmq_font)
    @view.setTypeface(rmq_font.to_typeface, rmq_font.sdk_text_style)
    @view.textSize = rmq_font.size
  end

  def gravity=(gravity)
    @view.gravity = convert_gravity(gravity)
  end

  def enabled=(enabled)
    @view.setEnabled(enabled)
  end

  def finalize
    super
    @text_style ||= Android::Graphics::Typeface::NORMAL
    typeface = Android::Graphics::Typeface.create(@font_family, @text_style) if @font_family
    @view.setTypeface(typeface, @text_style) # ok for typeface to be nil
  end
end

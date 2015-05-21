class RMQ
  def self.font
    RMQFont
  end

  def font
    RMQFont
  end
end

class RMQFont
  attr_accessor :name, :size, :font_family, :text_style

  def initialize(name, font_family, size, text_style)
    @name = name
    @font_family = font_family
    @text_style = text_style
    @size = size
  end

  def inspect
    "<RMQFont #{@name} \"#{@font_family}\" #{@size} #{@text_style}>"
  end

  def to_s
    self.inspect
  end

  def sdk_text_style
    case @text_style
    when :bold
      Android::Graphics::Typeface::BOLD
    when :italic
      Android::Graphics::Typeface::ITALIC
    when :bold_italic
      Android::Graphics::Typeface::BOLD_ITALIC
    when :normal
      Android::Graphics::Typeface::NORMAL
    end
  end

  def to_typeface
    Android::Graphics::Typeface.create(@font_family, sdk_text_style)
  end

  class << self
    def add_named(name, font_family, size, text_style)
      font_cache[name] = RMQFont.new(name, font_family, size, text_style)
    end

    def method_missing(font_key)
      # define_singleton_method isn't implemented in Android :'(
      font_cache[font_key]
    end

    def font_cache
      @font_cache ||= {}
    end
  end

end

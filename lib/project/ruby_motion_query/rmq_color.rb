# many hacks in this: we can't duplicate the iOS implementation because
# define_singleton_method isn't implemented in Android :'(
class RMQ

  def self.color(*params)
    if params.empty?
      RMQColor.shared
    else
      RMQColorFactory.build(params)
    end
  end

  def color(*params)
    self.class.color(*params)
  end

end

class RMQColor < Android::Graphics::Color

  def self.shared
    @instance ||= new
  end

  def add_named(key, hex_or_color)
    color = if hex_or_color.is_a?(String)
      self.class.parseColor(hex_or_color)
    else
      hex_or_color
    end

    color_cache[key] = color
  end

  def from_rgba(r, g, b, a)
    self.class.argb(a, r, b, g)
  end

  def method_missing(color_key)
    color_cache[color_key]
  end

  private

  def color_cache
    @color_cache ||= {}
  end

end

class RMQColorFactory

  class << self

    def from_hex(hex_string)
      if hex_string.length == 7
        # this is #RRGGBB format - we need to add the alpha
        color_str = "#FF#{hex_string[1..hex_string.length]}"
      end
      Android::Graphics::Color.parseColor(hex_string)
    end

  end

end


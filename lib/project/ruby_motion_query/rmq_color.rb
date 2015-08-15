# many hacks in this: we can't duplicate the iOS implementation because
# define_singleton_method isn't implemented in Android :'(
class RMQ

  def self.color(*params)
    if params.empty?
      RMQColor
    else
      RMQColorFactory.build(params)
    end
  end

  def color(*params)
    self.class.color(*params)
  end

end

class RMQColor < Android::Graphics::Color
  class << self
    def clear ; self::TRANSPARENT ; end
    def transparent ; self::TRANSPARENT ; end

    def white ; self::WHITE ; end
    def light_gray ; self::LTGRAY ; end
    def gray ; self::GRAY ; end
    def dark_gray ; self::DKGRAY ; end
    def black ; self::BLACK ; end

    #def cyan ; self::CYAN ; end
    #def magenta ; self::MAGENTA ; end
    #def yellow ; self::YELLOW ; end

    # These are special as the methods already exist
    #def blue ; self::BLUE ; end
    #def green ; self::GREEN ; end
    #def red ; self::RED ; end
    #def blue_color ; self::BLUE ; end
    #def green_color ; self::GREEN ; end
    #def red_color ; self::RED ; end

    # Maybe we should change this to: color(:white) rather than color.white, TOL


    def add_named(key, hex_or_color)
      c = if hex_or_color.is_a?(String)
        RMQColor.parseColor(hex_or_color)
      else
        hex_or_color
      end

      rmq_color_cache[key] = c
    end

    def method_missing(color_key)
      # define_singleton_method isn't implemented in Android :'(
      rmq_color_cache[color_key]
    end

    # Creates a color from a hex triplet (rgb) or quartet (rgba)
    #
    # @param hex with or without the #
    # @return [UIColor]
    # @example
    #   color.from_hex('#ffffff')
    #   color.from_hex('ffffff')
    #   color.from_hex('#336699cc')
    #   color.from_hex('369c')
    def from_hex(str)
      RMQColorFactory.from_hex(str)
    end

    # @return [UIColor]
    #
    # @example
    #   rmq.color.from_rgba(255,255,255,0.5)
    def from_rgba(r,g,b,a)
      RMQColorFactory.from_rgba(r,g,b,a)
    end

    def random
      RMQColorFactory.from_rgba(rand(255), rand(255), rand(255), 1.0)
    end

    def rmq_color_cache
      @_rmq_color_cache ||= {}
    end
  end

end

class RMQColorFactory

  class << self
    def build(params, dummy=nil, dummy_2=nil) # Dummy works around RM bug
      return RMQColor if params.empty?
      return from_rgba(*params) if params.count > 1

      param = params.first
      return from_hex(params.join) if param.is_a?(String)

      #return from_base_color(param) if base_values(param)
      #return try_rgba(param) if rgba_values(param)
      #return try_hsva(param) if hsva_values(param)
      #return try_hex(param) if hex_values(param)
    end

    def from_hex(hex_string)
      if hex_string.length == 7
        # this is #RRGGBB format - we need to add the alpha
        color_str = "#FF#{hex_string[1..hex_string.length]}"
      end
      RMQColor.parseColor(hex_string)
    end

    def from_rgba(r, g, b, a)
      android_a = a * 255
      RMQColor.argb(android_a, r, g, b)
    end
  end

end

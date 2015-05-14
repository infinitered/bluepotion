  class RMQ
    def device
      RMQDevice
    end

    def self.device
      RMQDevice
    end
  end

  class RMQDevice
    class << self

      def os_version
        @os_version ||= Android::Os::Build::VERSION.new.RELEASE.to_f
      end

      def os_code_name
        @os_code_name ||= Android::Os::Build::VERSION.new.CODENAME
      end

      def sdk_version
        @sdk_version ||= Android::Os::Build::VERSION.new.SDK_INT
      end

      def sdk_at_least?(version)
        version.to_i <= sdk_version
      end

      def display
        @display ||= RMQ.app.context.getSystemService(RMQ.app.context.WINDOW_SERVICE).defaultDisplay
      end

      def width
        @width ||= display.width
      end

      def height
        @height ||= display.height
      end

    end
  end

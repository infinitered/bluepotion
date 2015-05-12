  class RMQ
    def app
      RMQApp
    end

    def self.app
      RMQApp
    end
  end

  class RMQApp < PMApplication
    class << self

      def context
        PMContextManager.current_context
      end

      def window
        current_activity.getWindow
      end

      def current_activity
        PMApplication.current_activity
      end

      def home_screen_class
        PMApplication.home_screen_class
      end

      def current_fragment
        # TODO
      end
      alias :current_screen :current_fragment


      # @return [Symbol] Environment the app is running it
      def environment
        @_environment ||= RUBYMOTION_ENV.to_sym
      end

      # @return [Boolean] true if the app is running in the :release environment
      def release?
        environment == :release
      end
      alias :production? :release?

      # @return [Boolean] true if the app is running in the :test environment
      def test?
        environment == :test
      end

      # @return [Boolean] true if the app is running in the :development environment
      def development?
        environment == :development
      end
    end
  end


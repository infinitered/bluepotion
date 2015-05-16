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
      @context ||= PMContextManager.current_context
    end

    def window
      @window ||= current_activity.getWindow
    end

    def current_activity
      PMApplication.current_activity
    end

    def current_screen
      # TODO
    end

    def home_screen_class
      PMApplication.home_screen_class
    end

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


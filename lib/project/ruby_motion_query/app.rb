  class RMQ
    def app
      RMQApp
    end

    def self.app
      RMQApp
    end
  end

  class RMQApp
    class << self

      def window
        current_activity.getWindow
      end

      def current_activity
        PMApplication.current_activity
      end

    end
  end


module RubyMotionQuery
  class RMQ
    # @return [App]
    def app
      App
    end

    # @return [App]
    def self.app
      App
    end
  end

  class App
    class << self

      def window
        current_activity.getWindow
      end

      def current_activity
        Activity.new
      end
    end
  end
end


# RM-773
#module ProMotion
  class PMApplication < Android::App::Application

    class << self
      attr_accessor :current_activity
      attr_reader :home_screen_class

      def home_screen(home_screen_class)
        @home_screen_class = home_screen_class
      end
    end

    def onCreate
      PMContextManager.instance(self)
      on_create if respond_to?(:on_create)
    end

  end
#end

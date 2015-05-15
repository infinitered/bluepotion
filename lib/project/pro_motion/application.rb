# RM-773
#module ProMotion
  class PMApplication < Android::App::Application

    class << self
      attr_accessor :current_activity
      attr_reader :home_screen_class

      def home_screen(hclass)
        mp "PMApplication homescreen"
        @home_screen_class = hclass
      end
    end

    def onCreate
      mp "PMApplication onCreate"
      PMContextManager.instance(self)
      self.on_create if respond_to?(:on_create)
    end

  end
#end

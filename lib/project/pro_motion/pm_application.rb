# RM-773
#module ProMotion
  class PMApplication < Android::App::Application
    attr_accessor :home_screen_class, :context, :current_activity

    def onCreate
      mp "PMApplication onCreate", debugging_only: true

      # We can always get to the current application from PMApplication.current_application
      # but we set the child class's current_application too, in case someone uses that
      PMApplication.current_application = self
      self.class.current_application = self

      @context = self

      @home_screen_class = self.class.home_screen_class
      self.on_create if respond_to?(:on_create)
    end

    def window
      if @current_activity
        @window ||= @current_activity.getWindow
      end
    end

    def current_screen
      if @current_activity && (ca = @current_activity)
        if ca.is_a?(PMSingleFragmentActivity)
          ca.fragment
        end
      end
    end

    def guess_current_screen
      # TODO
      #ca.getFragmentManager.findFragmentById(Android::R::Id.fragment_container)
      #ca.getFragmentManager.frameTitle
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

    class << self
      attr_accessor :current_application, :home_screen_class

      def home_screen(hclass)
        mp "PMApplication home_screen", debugging_only: true
        @home_screen_class = hclass
      end

    end
  end
#end

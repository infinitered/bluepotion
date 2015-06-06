# RM-733
#module ProMotion
  class PMHomeActivity < PMNavigationActivity
    def on_create(saved_instance_state)
      mp "PMHomeActivity on_create", debugging_only: true
      @root_fragment ||= home_screen_class.new if home_screen_class
      super # Opens @root_fragment
    end

    def home_screen_class
      PMApplication.current_application.home_screen_class
    end
  end
#end

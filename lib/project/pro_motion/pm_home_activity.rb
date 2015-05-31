# RM-733
#module ProMotion
  class PMHomeActivity < PMSingleFragmentActivity
    def on_create(saved_instance_state)
      super

      mp "PMHomeActivity on_create", debugging_only: true
      create_home_screen
    end

    def create_home_screen
      home_screen_class = PMApplication.current_application.home_screen_class
      self.set_fragment home_screen_class.new if home_screen_class
    end
  end
#end

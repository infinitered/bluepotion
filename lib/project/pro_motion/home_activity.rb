# RM-733
#module ProMotion
  class PMHomeActivity < PMSingleFragmentActivity

    def onCreate(saved_instance_state)
      super
      home_screen_class = getApplication.class.home_screen_class
      set_fragment home_screen_class.new if home_screen_class 
    end

  end

#end

# RM-733
#module ProMotion
  #class PMHomeActivity < Android::App::Activity #PMSingleFragmentActivity
  class PMHomeActivity < PMSingleFragmentActivity
    # onCreate was not being called here, we debugged forever (literally).
    # So we just made abstract method nere and moved on. Ask Gant or Todd
    # about it.
    def on_create(saved_instance_state)
      mp "PMHomeActivity on_create"
      home_screen_class = getApplication.class.home_screen_class
      set_fragment home_screen_class.new if home_screen_class
    end
    def onCreate(saved_instance_state)
      mp "PMHomeActivity onCreate"
      # This method will never execute, but it needs to exist,
      # see above note. I'm sure this is a RM bug
      super
    end
  end

#end

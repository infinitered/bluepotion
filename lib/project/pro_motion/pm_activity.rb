#module ProMotion

  class PMActivity < Android::App::Activity

    def onCreate(saved_instance_state)
      super

      mp "PMActivity onCreate"
      #mp caller

      on_create(saved_instance_state)
      PMApplication.current_application.context
    end

    def on_create(saved_instance_state)
      mp "PMActivity on_create"
    end

    def onResume
      super
      PMApplication.current_application.current_activity = self
    end

    def onPause
      clear_references
      super
    end

    def onDestroy
      clear_references
      super
    end

    def clear_references
    end

  end

#end

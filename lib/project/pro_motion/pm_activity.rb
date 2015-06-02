#module ProMotion

  class PMActivity < Android::App::Activity

    def onCreate(saved_instance_state)
      super

      mp "PMActivity onCreate", debugging_only: true

      on_create(saved_instance_state)
      PMApplication.current_application.context
    end

    def on_create(saved_instance_state)
      mp "PMActivity on_create", debugging_only: true
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

    def onCreateOptionsMenu(menu)
      on_create_menu(menu)
    end

    def on_create_menu(_); end

  end

#end

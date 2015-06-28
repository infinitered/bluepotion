#module ProMotion

  class PMActivity < Android::App::Activity

    EXTRA_FRAGMENT_CLASS = "fragment_class"
    EXTRA_FRAGMENT_ARGUMENTS = "fragment_arguments"

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
      on_resume
      PMApplication.current_application.current_activity = self
    end
    def on_resume; end

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

    def onOptionsItemSelected(item)
      home_const = 16908332 # R.id.home
      return onBackPressed if item.getItemId == home_const
      # Don't call super if method returns false
      return true if on_options_item_selected(item) == false
      super
    end

    def onBackPressed
      # return if self.fragment && self.fragment.on_back_pressed == false
      super
      if self.fragment
        self.fragment.set_up_action_bar
        self.fragment.on_return
      else
        self.finish
      end
    end

    def open(screen, options={})
      find.screen.open screen, options
    end

    def close(options={})
      find.screen.close options
    end

  end

#end

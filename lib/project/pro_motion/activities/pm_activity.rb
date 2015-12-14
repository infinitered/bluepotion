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

    # These 2 methods are needed to pass on to inherited activities
    def onActivityResult(request_code, result_code, data)
      on_activity_result(request_code, result_code, data)
    end

    def on_activity_result(request_code, result_code, data)
      # Abstract
    end

    def onStart
      super
      on_start if respond_to?(:on_start)
    end

    def onNewIntent(intent)
      on_new_intent(intent) if respond_to?(:on_new_intent)
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
      on_destroy
      clear_references
      super
    end
    def on_destroy; end

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

    def onKeyDown(key_code, event)
      if self.fragment
        # share onKeyDown with super?
        super if self.fragment.on_key_down(key_code, event)
      end
    end

    def onBackPressed
      if find.screen.respond_to? :on_back_pressed
        find.screen.on_back_pressed
      end
      return if find.screen.class.allow_back_button == false
      super
      finish if fragmentManager.getBackStackEntryCount == 0
    end

    def open(screen, options={})
      find.screen.open screen, options
    end

    def close(options={})
      find.screen.close options
    end

    def set_content layout_xml
      layout_id = find.resource.layout(layout_xml)
      setContentView(layout_id)
    end

  end

#end

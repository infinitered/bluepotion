# An abstract Activity designed to host a single fragment.
# RM-733
#module ProMotion
  class PMSingleFragmentActivity < PMActivity
    attr_accessor :fragment_container, :fragment, :menu

    def on_create(saved_instance_state)
      super

      mp "PMSingleFragmentActivity on_create", debugging_only: true

      setup_fragment
    end

    def on_resume
      mp "PMSingleFragmentActivity on_resume", debugging_only: true

      setup_fragment unless @fragment_container
    end

    def setup_fragment
      @fragment_container = Potion::FrameLayout.new(self)
      @fragment_container.setId Potion::ViewIdGenerator.generate
      self.contentView = @fragment_container

      if (fragment_class = intent.getStringExtra(EXTRA_FRAGMENT_CLASS))
        if fragment_instance = Kernel.const_get(fragment_class.to_s).new
          set_fragment fragment_instance

          # Grab the fragment arguments and call them on the class
          if fragment_arguments = intent.getBundleExtra(EXTRA_FRAGMENT_ARGUMENTS)
            fragment_arguments = PMHashBundle.from_bundle(fragment_arguments).to_h

            fragment_arguments.each do |key, value|
              fragment_instance.send "#{key}=", value
            end
          end
        end
      end
    end

    def set_fragment(fragment)
      mp "PMSingleFragmentActivity set_fragment", debugging_only: true
      @fragment = fragment # useful for the REPL
      fragmentManager.beginTransaction.add(@fragment_container.getId, fragment, fragment.class.to_s).commit
    end

    def on_create_menu(menu)
      @menu = menu
      self.fragment.on_create_menu(menu) if self.fragment
    end

    def on_options_item_selected(item)
      self.fragment.on_options_item_selected(item) if self.fragment
    end

    def on_activity_result(request_code, result_code, data)
      if @fragment && @fragment.respond_to?(:activity_result)
        @fragment.activity_result(request_code, result_code, data)
      end
    end

  end
#end

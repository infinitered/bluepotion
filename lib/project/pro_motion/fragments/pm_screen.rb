# http://hipbyte.myjetbrains.com/youtrack/issue/RM-773 - can't put this in a module yet :(
#module ProMotion

  class PMScreen < Android::App::Fragment
    include PMScreenModule

    attr_accessor :view

    def onAttach(activity)
      super
      activity.on_fragment_attached(self) if activity.respond_to?(:on_fragment_attached)
      on_attach(activity)
    end
    def on_attach(activity); end

    def onCreate(bundle); super; on_create(bundle); end
    def on_create(bundle); end

    def onCreateView(inflater, parent, saved_instance_state)
      super

      if @xml_resource = self.class.xml_resource
        @view = inflater.inflate(r(:layout, @xml_resource), parent, false)
      else
        v = load_view
        @view ||= v
        @view.setId Potion::ViewIdGenerator.generate
      end

      set_up_action_bar
      on_create_view(inflater, parent, saved_instance_state)

      @view
    end
    def on_create_view(inflater, parent, saved_instance_state); end

    def load_view
      Potion::FrameLayout.new(self.activity)
    end

    def onActivityCreated(saved_instance_state)
      mp "PMScreen onActivityCreated" if RMQ.debugging?

      super

      @view.rmq_data.is_screen_root_view = true

      self.rmq.build(@view)

      if self.class.rmq_style_sheet_class
        self.rmq.stylesheet = self.class.rmq_style_sheet_class
        @view.rmq.apply_style(:root_view) #if @view.rmq.stylesheet.respond_to?(:root_view)
      end

      build_and_tag_xml_views

      set_title
      on_load
      on_activity_created
    end
    def on_load; end
    def on_activity_created; end

    def onStart; super; on_start; end
    def on_start; end
    alias :on_appear :on_start

    def onResume; super; on_resume; end
    def on_resume; end

    def on_create_menu(menu); end

    def onPause; super; on_pause; end
    def on_pause; end

    def onStop; super; on_stop; end
    def on_stop; end

    def onDestroyView; super; on_destroy_view; end
    def on_destroy_view; end

    def onDestroy; super; on_destroy; end
    def on_destroy; end

    def onDetach
      super
      on_detach
      self.activity.on_fragment_detached(self) if self.activity.respond_to?(:on_fragment_detached)
    end
    def on_detach; end

  end

#end

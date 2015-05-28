# http://hipbyte.myjetbrains.com/youtrack/issue/RM-773 - can't put this in a module yet :(
#module ProMotion

  class PMScreen < Android::App::Fragment
    include PMScreenModule

    attr_accessor :view

    def onCreateView(inflater, parent, saved_instance_state)
      super

      if self.class.xml_resource
        @view = inflater.inflate(r(:layout, self.class.xml_resource), parent, false)
      else
        @view = load_view
        @view.setId Potion::ViewIdGenerator.generate
      end

      action_bar.hide if hide_action_bar?
      tag_xml_widgets_with_their_id

      @view
    end

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

      self.action_bar.title = self.class.bars_title
      self.activity.title = self.class.bars_title

      on_load
    end


    private

    def tag_xml_widgets_with_their_id
      return unless (xml_widget_ids = self.class.xml_widget_ids)

      package_name = activity.getApplicationInfo.packageName
      key = "id"
      xml_widget_ids.each do |id|
        id_s = id.to_s
        resource_id = resources.getIdentifier(id_s, key, package_name)
        view = @view.findViewById(resource_id)
        view.rmq_data.tag(id_s.to_sym)
      end
    end

    def hide_action_bar?
      # RM-???: comparing nil to false causes ART crash
      !self.class.show_action_bar.nil? && self.class.show_action_bar == false
    end

  end

#end

# http://hipbyte.myjetbrains.com/youtrack/issue/RM-773 - can't put this in a module yet :(
#module ProMotion

  class PMScreen < Android::App::Fragment
    include PMScreenModule

    attr_accessor :view

    def rmq_data
      @_rmq_data ||= RMQScreenData.new
    end

    def rmq(*working_selectors)
      crmq = (rmq_data.cached_rmq ||= RMQ.create_with_selectors([], self))

      if working_selectors.length == 0
        crmq
      else
        RMQ.create_with_selectors(working_selectors, self, crmq)
      end
    end
    #alias :find :rmq

    def root_view
      rmq.activity.findViewById(R.id.PageLayout)
    end

    def onCreateView(inflater, parent, saved_instance_state)
      super
      if self.class.xml_resource
        @view = inflater.inflate(r(:layout, self.class.xml_resource), parent, false)
      else
        @view = Android::Widget::FrameLayout.new(activity)
        @view.setId Potion::ViewIdGenerator.generate
      end
      action_bar.hide if hide_action_bar?
      setup_xml_widgets
      #@rmq = RMQ.new(@view, stylesheet, activity)
      on_load if respond_to?(:on_load)
      # TODO: how will we pass this back if we don't use XML?
      @view
    end

    private

    def setup_xml_widgets
      return unless (xml_widget_ids = self.class.xml_widget_ids)
      xml_widget_ids.each do |id|
        instance_variable_set("@#{id.to_s}".to_sym, find(id))
      end
    end

    def hide_action_bar?
      # RM-???: comparing nil to false causes ART crash
      !self.class.show_action_bar.nil? && self.class.show_action_bar == false
    end

    def stylesheet
      return nil unless self.class.stylesheet_class
      @stylesheet ||= self.class.stylesheet_class.new
    end

  end

#end

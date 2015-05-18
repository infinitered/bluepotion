# http://hipbyte.myjetbrains.com/youtrack/issue/RM-773 - can't put this in a module yet :(
#module ProMotion

  class PMScreen < Android::App::Fragment
    include PMScreenModule

    attr_accessor :view

    def rmq_data
      @_rmq_data ||= RMQScreenData.new
    end

    def stylesheet
      self.rmq.stylesheet
    end

    def stylesheet=(value)
      self.rmq.stylesheet = value
    end

    def rmq(*working_selectors)
      crmq = (rmq_data.cached_rmq ||= RMQ.create_with_selectors([], self))

      if working_selectors.length == 0
        crmq
      else
        RMQ.create_with_selectors(working_selectors, self, crmq)
      end
    end

    def root_view
      self.getView
    end

    def onCreateView(inflater, parent, saved_instance_state)
      super

      if self.class.xml_resource
        @view = inflater.inflate(r(:layout, self.class.xml_resource), parent, false)
      else
        @view = load_view
        @view.setId Potion::ViewIdGenerator.generate
      end

      action_bar.hide if hide_action_bar?
      setup_xml_widgets

      # TODO: how will we pass this back if we don't use XML?
      @view
    end

    def load_view
      Potion::FrameLayout.new(self.activity)
    end

    def onActivityCreated(saved_instance_state)
      super
      @view.rmq_data.is_screen_root_view = true

      self.rmq.build(@view)

      if self.class.rmq_style_sheet_class
        self.rmq.stylesheet = self.class.rmq_style_sheet_class
        @view.rmq.apply_style(:root_view) #if @view.rmq.stylesheet.respond_to?(:root_view)
      end

      on_load
    end

    def on_load
      # abstract
    end

    def append_view(view_or_class, style=nil, opts={})
      self.rmq.append_view(view_or_class, style, opts)
    end

    def append_view!(view_or_class, style=nil, opts={})
      self.rmq.append_view(view_or_class, style, opts).get
    end

    class << self

      def stylesheet(style_sheet_class)
        @rmq_style_sheet_class = style_sheet_class
      end

      def rmq_style_sheet_class
        @rmq_style_sheet_class
      end

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

  end

#end

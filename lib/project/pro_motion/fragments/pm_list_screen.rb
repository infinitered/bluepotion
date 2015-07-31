# http://hipbyte.myjetbrains.com/youtrack/issue/RM-773 - can't put this in a module yet :(
#module ProMotion

  module PMListReusability

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      attr_reader :pm_cell_types

      def cell_types(new_cell_types=[])
        @pm_cell_types ||= new_cell_types
      end

    end
  end


  class PMListScreen < Android::App::ListFragment
    include PMScreenModule
    include PMListReusability

    attr_accessor :view

    def table_data
      mp "Implement a table_data method in #{self.inspect}."
      []
    end

    def load_view
      # Potion::LinearLayout.new(self.activity)
      lv = create(Potion::ListView).tag(:list)
      self.view = lv.get
      # find(self.view).style do |st|
        # st.layout_width = :match_parent
        # st.layout_height = :match_parent
        # st.layout_weight = 1
        # st.view.drawSelectorOnTop = false
      # end
      # self.view
    end

    def screen_setup
      add_table_view
      add_empty_view
      add_adapter
    end

    def add_table_view
      # create(Potion::ListView, :list).style do |st|
      #   st.layout_width = :match_parent
      #   st.layout_height = :match_parent
      #   st.layout_weight = 1
      #   st.view.drawSelectorOnTop = false
      # end
    end

    def add_empty_view
      # append(Potion::TextView, :empty).style do |st|
      #   st.layout_width = :match_parent
      #   st.layout_height = :match_parent
      #   st.background = "#FFFFFF"
      #   st.text = "No data"
      # end
    end

    def add_adapter
      self.view.setAdapter(adapter)
    end

    def adapter
      @adapter ||= begin
        td = table_data
        if td.is_a?(Array)
          cells = td.first[:cells]
          PMBaseAdapter.new(data: cells, view_types: self.class.pm_cell_types)
        elsif td.is_a?(Hash)
          mp "Please supply a cursor in #{self.inspect}#table_data." unless td[:cursor]
          PMCursorAdapter.new(td)
        end
      end
    end

    def update_table_data
      # base adapters must reacquire their data from the PMListScreen "delegate"
      if adapter.instance_of?(PMCursorAdapter)
        # TODO:  Reload for PMCursorAdapter
      elsif adapter.is_a?(PMBaseAdapter)
        td = table_data
        adapter.data = td && td.first && td.first[:cells]
      end
      adapter.notifyDataSetChanged
    end

    ### Boilerplate from PMScreen ###

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

      set_up_action_bar(self.class.action_bar_options)

      on_create_view(inflater, parent, saved_instance_state)

      @view
    end
    def on_create_view(inflater, parent, saved_instance_state); end

    # def load_view
    #   Potion::FrameLayout.new(self.activity)
    # end

    def onActivityCreated(saved_instance_state)
      mp "PMScreen onActivityCreated" if RMQ.debugging?

      super

      @view.rmq_data.is_screen_root_view = true

      self.rmq.build(@view)

      screen_setup

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

# http://hipbyte.myjetbrains.com/youtrack/issue/RM-773 - can't put this in a module yet :(
#module ProMotion

  class PMListScreen < PMScreen
    include RefreshableList

    def table_data
      mp "Implement a table_data method in #{self.inspect}."
      []
    end

    def screen_setup
      # This method will grow as BP grows towards RP
      set_up_refreshable
    end

    def set_up_refreshable
      # named get_refreshable bc of Promotion # Possible PR to is_refreshable?
      if self.class.respond_to?(:get_refreshable) && self.class.get_refreshable
        make_refreshable(self.class.get_refreshable_params)
      end
    end

    def load_view
      # Dynamic Pull to Refresh?
      # v = Potion::View.new(app.context) # TODO, fix this horrible hack
      # ptr_v = rmq(v).create(In::Srain::Cube::Views::Ptr::PtrClassicFrameLayout).tag(:ptr_parent).style do |st|
      #   st.layout_width = :wrap_content
      #   st.layout_height = :wrap_content
      #   st.background_color = rmq.color.black
      # end
      # lv = ptr_v.append(Potion::ListView).tag(:list)
      # self.view = ptr_v.get


      # FOR NOW

      # We need a simple listview - that's all
      Potion::ListView.new(app.context)
    end

    def extended_screen_setup
      add_adapter
    end

    def find_list_view
      find.activity.find(Potion::ListView)
    end

    def add_adapter
      found_listviews = find_list_view
      if found_listviews.count.zero?
        mp "PM ListView Error - We couldn't find any listviews on this screen."
      elsif found_listviews.count > 1
        mp "PM ListView Error - Too many ListViews, please implement add_adapter on your screen."
      else
        found_listviews.get.adapter = adapter
      end
    end

    def adapter
      @adapter ||= begin
        td = table_data
        if td.is_a?(Array)
          cells = td.first[:cells]
          # Pass data to adapter, and identify if dynamic data will be used, too.
          PMBaseAdapter.new(data: cells, extra_view_types: self.class.extra_view_types).tap { |a| a.screen = self }

        elsif td.is_a?(Hash)
          mp "Please supply a cursor in #{self.inspect}#table_data." unless td[:cursor]
          PMCursorAdapter.new(td).tap { |a| a.screen = self }
        end
      end
    end

    def update_table_data
      # base adapters must reacquire their data from the PMListScreen "delegate"
      if adapter.instance_of?(PMCursorAdapter)
        # TODO: Perhaps not the best method, but it works
        @adapter = PMCursorAdapter.new(table_data).tap { |a| a.screen = self }
        add_adapter
      elsif adapter.is_a?(PMBaseAdapter)
        td = table_data
        adapter.data = td && td.first && td.first[:cells]
      end
      adapter.notifyDataSetChanged
    end

    # first time is a set, all after are get
    def self.extra_view_types(*extra_types)
      extra_types ||= []
      @_extra_view_types ||= extra_types
    end

    def on_destroy
      return unless @adapter
      @adapter.screen = nil
      @adapter = nil
    end

  end

#end

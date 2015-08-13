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
      v = Potion::View.new(app.context) # TODO, fix this horrible hack
      lv = rmq(v).create(Potion::ListView).tag(:list)
      self.view = lv.get
    end

    def extended_screen_setup
      add_adapter
    end

    def add_adapter
      found_listviews = find.activity.find(Potion::ListView)
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
          PMBaseAdapter.new(data: cells, extra_view_types: self.class.extra_view_types)
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

    # first time is a set, all after are get
    def self.extra_view_types(*extra_types)
      extra_types ||= []
      @_extra_view_types ||= extra_types
    end




    ############## THIS SHOULD BE IN A SEPARATE FILE ##############
    ###############  RMA WOULDN"T LET ME USE A MODULE #############



    def make_refreshable(params={})
      @ptr = find!(In::Srain::Cube::Views::Ptr::PtrFrameLayout)
      header = In::Srain::Cube::Views::Ptr::Header::MaterialHeader.new(app.context)
      ptr_colors = params[:color_array] || [color.dark_gray]
      header.setColorSchemeColors(ptr_colors)
      header.setPtrFrameLayout(@ptr)
      @ptr.setHeaderView(header)
      @ptr.addPtrUIHandler(header)
      @ptr.ptrHandler = PtrHandler.new do |frame|
        # should call on_refresh if respond_to?(:on_refresh)
        frame.refreshComplete
      end
    end

    def self.refreshable(params = {})
      @refreshable_params = params
      @refreshable = true
    end

    def self.get_refreshable
      @refreshable ||= false
    end

    def self.get_refreshable_params
      @refreshable_params ||= nil
    end

    def stop_refreshing
      @ptr.refreshComplete
    end

    end

#end

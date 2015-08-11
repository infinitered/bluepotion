# http://hipbyte.myjetbrains.com/youtrack/issue/RM-773 - can't put this in a module yet :(
#module ProMotion

  class PMListScreen < PMScreen

    def table_data
      mp "Implement a table_data method in #{self.inspect}."
      []
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
      self.view.setAdapter(adapter)
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

  end

#end

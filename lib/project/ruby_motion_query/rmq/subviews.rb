class RMQ
  def add_view(view_or_class, opts={})
    subviews_added = []

    selected.each do |selected_view|
      created = false
      appended = false
      built = false

      if view_or_class.is_a?(Potion::View)
        new_view = view_or_class
      else
        created = true
        new_view = view_or_class.new(RMQApp.context)
      end

      new_view.setId(Potion::ViewIdGenerator.generate)

      rmq_data = new_view.rmq_data

      unless rmq_data.built
        rmq_data.built = true # build only once
        built = true
      end

      rmq_data.activity = self.activity
      rmq_data.screen = self.screen

      subviews_added << new_view

      unless opts[:do_not_add]
        #if at_index = opts[:at_index]
          #selected_view.insertSubview(new_view, atIndex: at_index)
        #elsif below_view = opts[:below_view]
          #selected_view.insertSubview(new_view, belowSubview: below_view)
        #else
          selected_view.addView(new_view)
        #end

        appended = true
      end

      if created
        new_view.rmq_created
      end
      new_view.rmq_build if built
      new_view.rmq_appended if appended

      if self.stylesheet
        apply_style_to_view(new_view, opts[:style]) if opts[:style]
      end
    end

    viewq = RMQ.create_with_array_and_selectors(subviews_added, selectors, @originated_from, self)
    opts[:block].call viewq if opts[:block]
    opts[:raw_block].call viewq.get if opts[:raw_block]
    viewq
  end
  alias :insert :add_view

  def append_view(view_or_class, style=nil, opts={})
    # TODO this seems to be an RM bug, style and opts are set to numbers if they
    # aren't provided
    #style = nil unless style.is_a?(Symbol)
    #opts = {} unless opts.is_a?(Hash)

    opts[:style] = style
    #opts[:block] = block if block
    out = self.add_view(view_or_class, opts)
    out
  end

  def append_view!(view_or_class, style=nil, opts={})
    self.append_view(view_or_class, style, opts).get
  end

  def create(view_or_class, style=nil, opts={})
  end

  def create!(view_or_class, style=nil, opts={})
  end

  def build(view_or_class, style=nil, opts={})
  end

  def build!(view_or_class, style=nil, opts={})
  end
end

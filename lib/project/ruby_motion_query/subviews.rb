class RMQ
  def add_view(view_or_class, opts={})
    subviews_added = []

    selected.each do |selected_view|
      created = false
      appended = false
      built = false

      if view_or_constant.is_a?(Potion::View)
        new_view = view_or_constant
      else
        created = true
        new_view = view_or_constant.new(RMQApp.context)
        mp "created"
        #new_view = create_view(view_or_constant, opts)
      end

      new_view.setId(Potion::ViewIdGenerator.generate)

      #rmq_data = new_view.rmq_data

      #unless rmq_data.built
        #rmq_data.built = true # build only once
        #built = true
      #end

      #rmq_data.view_controller = self.weak_view_controller

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

    view = RMQ.create_with_array_and_selectors(subviews_added, selectors, @originated_from, self)
    opts[:block].call view if opts[:block]
    opts[:raw_block].call view.get if opts[:raw_block]
    view

    #subview.setId(Potion::ViewIdGenerator.generate)
    #view.addView(subview)
    #if stylesheet
      #apply_style_to_view(subview, style_name)
    #end
    #RMQ.new(subview, stylesheet, context)
  end
  alias :insert :add_view

  def append(view_or_class, style=nil, opts={})
    opts[:style] = style
    opts[:block] = block if block
    add_view(view_or_class, opts)
  end

  def append!(view_or_class, style=nil, opts={})
    append(view_or_class, style, opts).get
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

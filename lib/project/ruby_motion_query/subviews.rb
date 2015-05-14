class RMQ
  def add_element(element_or_class, opts={})
    subviews_added = []

    selected.each do |selected_element|
      created = false
      appended = false
      built = false

      if element_or_constant.is_a?(Potion::View)
        new_element = element_or_constant
      else
        created = true
        new_element = element_or_constant.new(RMQApp.context)
        mp "created"
        #new_element = create_view(element_or_constant, opts)
      end

      new_element.setId(Potion::ViewIdGenerator.generate)

      #rmq_data = new_element.rmq_data

      #unless rmq_data.built
        #rmq_data.built = true # build only once
        #built = true
      #end

      #rmq_data.view_controller = self.weak_view_controller

      subviews_added << new_element

      unless opts[:do_not_add]
        #if at_index = opts[:at_index]
          #selected_element.insertSubview(new_element, atIndex: at_index)
        #elsif below_view = opts[:below_view]
          #selected_element.insertSubview(new_element, belowSubview: below_view)
        #else
          selected_element.addView(new_element)
        #end

        appended = true
      end

      if created
        new_element.rmq_created
      end
      new_element.rmq_build if built
      new_element.rmq_appended if appended

      if self.stylesheet
        apply_style_to_view(new_element, opts[:style]) if opts[:style]
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
  alias :insert :add_element

  def append(element_or_class, style=nil, opts={})
    opts[:style] = style
    opts[:block] = block if block
    add_element(element_or_class, opts)
  end

  def append!(element_or_class, style=nil, opts={})
    append(element_or_class, style, opts).get
  end

  def create(element_or_class, style=nil, opts={})
  end

  def create!(element_or_class, style=nil, opts={})
  end

  def build(element_or_class, style=nil, opts={})
  end

  def build!(element_or_class, style=nil, opts={})
  end
end

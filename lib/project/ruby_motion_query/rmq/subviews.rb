class RMQ
  def add_subview(view_or_class, opts={})
    subviews_added = []

    selected.each do |selected_view|
      created = false
      appended = false
      built = false
      tag_xml_layout = false

      if view_or_class.is_a?(Potion::View)
        new_view = view_or_class
      elsif view_or_class.is_a?(Symbol) # Inflate from xml
        created = true
        layout = RMQResource.layout(view_or_class)

        inflater = Potion::LayoutInflater.from(self.activity)
        new_view = inflater.inflate(layout, nil)
        tag_xml_layout = true
      else
        created = true
        new_view = view_or_class.new(RMQ.app.context)
        new_view.setId(Potion::ViewIdGenerator.generate)
      end

      rmq_data = new_view.rmq_data

      unless rmq_data.built
        rmq_data.built = true # build only once
        built = true
      end

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

      tag_all_from_resource_entry_name(new_view) if tag_xml_layout
    end

    viewq = RMQ.create_with_array_and_selectors(subviews_added, selectors, @originated_from, self)
    opts[:block].call viewq if opts[:block]
    opts[:raw_block].call viewq.get if opts[:raw_block]
    viewq
  end
  alias :insert :add_subview

  def tag_all_from_resource_entry_name(view)
    view.rmq.find.each do |view|
      if ren = view.resource_entry_name
        view.rmq_data.tag(ren.to_sym)
      end
    end
  end


  # Removes the selected views from their parent's (superview) subview array
  #
  # @example
  #   rmq(a_view, another_view).remove
  #
  # @return [RMQ]
  def remove
    selected.each { |view| view.parent.removeView(view) }
    self
  end

  def append(view_or_class, style=nil, opts={}, dummy=nil) # <- dummy is to get around RM bug)
    opts[:style] = style
    #opts[:block] = block if block
    out = self.add_subview(view_or_class, opts)
    out
  end

  def append!(view_or_class, style=nil, opts={})
    self.append(view_or_class, style, opts).get
  end

  def create(view_or_constant, style = nil, opts = {}, &block)
    # TODO, refactor so that add_subview uses create, not backwards like it is now
    opts[:do_not_add] = true
    opts[:style] = style
    opts[:block] = block if block
    add_subview view_or_constant, opts
  end

  def create!(view_or_constant, style=nil, opts = {}, &block)
    opts[:raw_block] = block if block
    create(view_or_constant, style, opts).get
  end

  def build(view_or_constant, style = nil, opts = {}, &block)
    opts[:do_not_add] = true
    opts[:style] = style
    opts[:block] = block if block
    add_subview view_or_constant, opts
  end

  def build!(view_or_constant, style = nil, opts = {}, &block)
    opts[:raw_block] = block if block
    build(view_or_constant, style, opts).get
  end
end

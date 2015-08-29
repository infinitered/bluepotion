class PMBaseAdapter < Android::Widget::BaseAdapter
  attr_accessor :data

  def initialize(opts={})
    super()
    self.data = opts.fetch(:data, [])
    @extra_view_types = opts.fetch(:extra_view_types, [])
  end

  def screen
    @screen ||= rmq.screen
  end
  def screen=(value)
    @screen = value
  end

  def areAllItemsEnabled(); are_all_items_enabled?; end
  def are_all_items_enabled?
    true
  end

  def isEnabled(position); is_enabled?(position); end
  def is_enabled?(position)
    true
  end

  def isEmpty(); is_empty?; end
  def is_empty?
    data.blank?
  end

  def hasStableIds(); has_stable_ids?; end
  def has_stable_ids?
    true
  end

  def getViewTypeCount(); view_type_count; end
  def view_type_count()
    # all custom items added up (+1 for non-custom)
    view_types.length + 1
  end

  def getItemViewType(position); item_view_type_id(position); end
  def item_view_type_id(position)
    data_item = self.item_data(position)
    idx = nil
    if data_item[:prevent_reuse]
      idx = Android::Widget::Adapter::IGNORE_ITEM_VIEW_TYPE
    else
      # get custom cell index
      idx = view_types.index(data_item[:cell_xml] || data_item[:cell_class])
      # Shift custom cells up 1, no custom == index 0
      idx = idx ? (idx + 1) : 0
    end

    idx
  end

  def getCount(); count(); end
  def count()
    data.length
  end

  def getItem(position); item_data(position); end
  def item_data(position)
    data[position]
  end

  def getItemId(position); item_id(position); end
  def item_id(position)
    position
  end

  def getView(position, convert_view, parent); view(position, convert_view, parent); end
  def view(position, convert_view, parent)
    data = item_data(position)
    out = selected_view(convert_view, data)
    update_view(out, data)
    if data[:action]
      find(out).on(:tap) do
        arguments = action_arguments data, position
        screen.send(data[:action], arguments, position)
      end
    end
    out
  end

  # configure what to pass back when we tap that action
  def action_arguments(data, position)
    data[:arguments]
  end

  def update_view(view, data)
    update = data[:update]
    if update.is_a?(Proc)
      update.call(out, data)
    elsif update.is_a?(Symbol) || update.is_a?(String)
      if screen.respond_to?(update)
        screen.send(update, view, data)
      else
        mp "Warning: #{screen.class} does not respond to #{update}"
      end
    elsif data[:properties]
      data[:properties].each do |k, v|
        if view.respond_to?("#{k}=")
          view.send("#{k}=", v)
        else
          mp "Warning: #{view.class} does not respond to #{k}="
        end
      end
    elsif view.is_a?(Potion::TextView)
      # Specific to use of Simple list item 1
      view.text = data[:title]
    elsif update
      mp "We don't know how to update your cell"
    end
  end

  def view_types
    # unique cell_xmls and cell_classes + any potentially dynamic types
    @_vt ||= (data.map{ |i| i[:cell_xml] || i[:cell_class]}.compact + @extra_view_types).uniq
  end

  def selected_view(cv, data)
    row_view = cv
    unless row_view
      if data[:cell_class]
        row_view = rmq.create!(data[:cell_class])
      elsif data[:cell_xml]
        row_view = inflate_row(data[:cell_xml])
        rmq.tag_all_from_resource_entry_name(row_view)
      else
        # Default is Sipmle List Item 1
        # TODO:  Possibly use Android::R::Layout::Simple_list_item_2 which has subtitle
        #https://android.googlesource.com/platform/frameworks/base/+/master/core/res/res/layout/simple_list_item_2.xml
        row_view = inflate_row(Android::R::Layout::Simple_list_item_1)
      end
    end
    row_view
  end

  def inflate_row(xml_resource)
    inflater = Potion::LayoutInflater.from(find.activity)
    row_view = inflater.inflate(xml_resource, nil, true)
  end

end

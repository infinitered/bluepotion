class PMBaseAdapter < Android::Widget::BaseAdapter
  attr_accessor :data

  def initialize(opts={})
    super()
    @data = opts.fetch(:data, [])
  end

  def screen
    @screen ||= rmq.screen
  end
  def screen=(value)
    @screen
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
    1
  end

  def getItemViewType(position); item_view_type_id(position); end
  def item_view_type_id(position)
    0
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
      find(out).on(:tap) { find.screen.send(data[:action], data[:arguments], position) }
    end
    out
  end

  def update_view(view, data)
    update = data[:update]
    if update.is_a?(Proc)
      update.call(out, data)
    elsif update.is_a?(Symbol) || update.is_a?(String)
      if find.screen.respond_to?(update)
        find.screen.send(update, view, data)
      else
        mp "Warning: #{find.screen.class} does not respond to #{update}"
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

  def selected_view(cv, data)
    row_view = cv
    unless row_view
      if data[:cell_class]
        row_view = rmq.create!(data[:cell_class])
      elsif data[:cell_xml]
        row_view = inflate_row(data[:cell_xml])
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

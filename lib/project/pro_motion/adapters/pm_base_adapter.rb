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

  def getItem(position); item(position); end
  def item(position)
    data[position]
  end

  def getItemId(position); item_id(position); end
  def item_id(position)
    position
  end

  def getView(position, convert_view, parent); view(position, convert_view, parent); end
  def view(position, convert_view, parent)
    data = item(position)
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
      find.screen.send(update, out, data)
    else
      # Specific to use of Simple list item 1
      view.text = data[:title]
    end
  end

  def selected_view(cv, data)
    row_view = cv
    unless row_view
      if data[:cell_class]
        row_view = rmq.create!(data[:cell_class])
      else
        # Default is Sipmle List Item 1
        # TODO:  Possibly use Android::R::Layout::Simple_list_item_2 which has subtitle
        #https://android.googlesource.com/platform/frameworks/base/+/master/core/res/res/layout/simple_list_item_2.xml
        inflater = Potion::LayoutInflater.from(find.activity)
        row_view = inflater.inflate(Android::R::Layout::Simple_list_item_1, nil, true)
      end
    end
    row_view
  end
end

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
    out = convert_view || rmq.create!(data[:cell_class] || Potion::TextView)
    update_view(out, data[:title])
    if data[:action]
      find(out).on(:tap) { find.screen.send(data[:action], data[:arguments], position) }
    end
    out
  end

  def update_view(view, data)
    if cell_options[:update].is_a?(Proc)
      cell_options[:update].call(out, data)
    elsif cell_options[:update].is_a?(Symbol) || cell_options[:update].is_a?(String)
      find.screen.send(cell_options[:update], out, data)
    else
      out.text = data
    end
  end
end

class PMBaseAdapter < Android::Widget::BaseAdapter
  include PMAdapterModule

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
    out = convert_view || rmq.create!(Potion::TextView)
    data = item(position)
    update_view(out, data)
    out
  end

  def update_view(view, data)
    out.text = data
  end
end

class PMCursorAdapter < PMBaseAdapter
  attr_accessor :cursor
  attr_accessor :cell_options

  def initialize(opts={})
    super()
    @cursor = opts.fetch(:cursor)
    @cell_options = opts.fetch(:cell, 1)
  end

  def count
    cursor.count
  end

  def item(position)
    cursor.moveToPosition(position)
    cursor
  end

  def item_view_type_id(position)
    0
  end

  def view(position, convert_view, parent)
    data = item(position)
    out = convert_view || rmq.create!(cell_options[:cell_class] || Potion::TextView)
    update_view(out, data)
    if cell_options[:action]
      find(out).on(:tap) do
        find.screen.send(cell_options[:action], item(position), position)
      end
    end
    out
  end

  def update_view(out, data)
    if cell_options[:update].is_a?(Proc)
      cell_options[:update].call(out, data)
    elsif cell_options[:update].is_a?(Symbol) || cell_options[:update].is_a?(String)
      find.screen.send(cell_options[:update], out, data)
    else
      out.text = data.getString(cell_options[:title_column].to_i)
    end
  end

end

__END__

def table_data
  {
    cursor: my_cursor,
    title_column: 0,
  }
end


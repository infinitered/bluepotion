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

  def view(position, convert_view, parent)
    data = item(position)
    out = convert_view || rmq.create!(cell_options[:cell_class] || Potion::TextView)
    update_view(out, data)
    if cell_options[:action]
      find(out).on(:tap) { find.screen.send(cell_options[:action], data, position) }
    end
    out
  end

  def update_view(out, data)
    out.text = data.getString(cell_options[:title_column])
  end

end

__END__

def table_data
  {
    cursor: my_cursor,
    title_column: 0,
  }
end


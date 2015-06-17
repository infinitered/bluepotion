class PMCursorAdapter < PMBaseAdapter
  attr_accessor :cursor
  attr_accessor :title_column

  def initialize(opts={})
    super()
    @cursor = opts.fetch(:cursor)
    @title_column = opts.fetch(:title_column, 1)
  end

  def count
    cursor.count
  end

  def item(position)
    cursor.moveToPosition(position)
    cursor
  end

  def update_view(out, data)
    out.text = data.getString(title_column)
  end

end

__END__

def table_data
  {
    cursor: my_cursor,
    title_column: 0,
  }
end


class PMCursorAdapter < PMBaseAdapter
  attr_accessor :cursor
  attr_accessor :cell_options

  def initialize(opts={})
    super()
    @cursor = opts.fetch(:cursor)
    @cell_options = opts.fetch(:cell, 1)
    @cell_options[:cursor] = @cursor # slip the cursor inside so callbacks have it
  end

  def count
    cursor.count
  end

  def item_data(position)
    cursor.moveToPosition(position)
    cell_options # return the one & only one cell_options
  end

  # slighty different arguments to send when tapping
  def action_arguments(data, position)
    item_data(position) # move the cursor into position
    @cursor
  end

end


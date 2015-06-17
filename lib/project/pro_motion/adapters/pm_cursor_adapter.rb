class PMCursorAdapter < PMBaseAdapter
  include PMAdapterModule

  attr_accessor :cursor

  def initialize(opts={})
    super()
    @cursor = opts.fetch(:cursor)
  end



end

__END__

def table_data
  {
    cursor: my_cursor,
    bind_views: {
      my_view_1: 0,
      my_view_2: 1,
      my_view_3: 2,
    },
  }
end


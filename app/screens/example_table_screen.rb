class ExampleTableScreen < PMListScreen
  action_bar true
  stylesheet ExampleTableScreenStylesheet
  title "Example Table Screen"

  def load_view
    mp "ExampleTableScreen load_view"
    Potion::ListView.new(self.activity)
  end

  def table_data
    [{
      title: "Northwest States",
      cells: [
        { title: "Oregon", action: :visit_state, arguments: { state: "oregon" }},
        { title: "Washington", action: :visit_state, arguments: { state: "washington" }}
      ]
    }]
  end

  def visit_state (args, position)
    mp "You clicked on #{args[:state]}"
  end

  def on_load
    mp "ExampleTableScreen on_load"
    #find.log_tree Errors
  end

  def people=(value)
    mp "People set: #{value}"
  end

  def test_int=(value)
    mp "test_int set: #{value}"
  end

  def test_symbol=(value)
    mp "test_symbol set: #{value}"
  end
end

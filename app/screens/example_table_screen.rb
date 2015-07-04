class ExampleTableScreen < PMScreen
  action_bar true
  stylesheet ExampleTableScreenStylesheet
  title "Example Table Screen"

  def load_view
    mp "ExampleTableScreen load_view"

    Potion::LinearLayout.new(self.activity)
  end

  def on_load
    mp "ExampleTableScreen on_load"

    append(Potion::TextView,  :hello_label)

    find.log_tree
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

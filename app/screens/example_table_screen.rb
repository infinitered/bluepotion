class ExampleTableScreen < PMScreen

  uses_action_bar true
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

end

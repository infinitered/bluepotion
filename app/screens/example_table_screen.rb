class ExampleTableScreen < PMListScreen
  action_bar true
  stylesheet ExampleTableScreenStylesheet
  title "Example Table Screen"

  # def load_view
  #   mp "ExampleTableScreen load_view"
  #   Potion::ListView.new(self.activity)
  # end

  def table_data
    states = [
      ["AK", "Alaska"],
      ["AL", "Alabama"],
      ["AR", "Arkansas"],
      ["AS", "American Samoa"],
      ["AZ", "Arizona"],
      ["CA", "California"],
      ["CO", "Colorado"],
      ["CT", "Connecticut"],
      ["DC", "District of Columbia"],
      ["DE", "Delaware"],
      ["FL", "Florida"],
      ["GA", "Georgia"],
      ["GU", "Guam"],
      ["HI", "Hawaii"],
      ["IA", "Iowa"],
      ["ID", "Idaho"],
      ["IL", "Illinois"],
      ["IN", "Indiana"],
      ["KS", "Kansas"],
      ["KY", "Kentucky"],
      ["LA", "Louisiana"],
      ["MA", "Massachusetts"],
      ["MD", "Maryland"],
      ["ME", "Maine"],
      ["MI", "Michigan"],
      ["MN", "Minnesota"],
      ["MO", "Missouri"],
      ["MS", "Mississippi"],
      ["MT", "Montana"],
      ["NC", "North Carolina"],
      ["ND", "North Dakota"],
      ["NE", "Nebraska"],
      ["NH", "New Hampshire"],
      ["NJ", "New Jersey"],
      ["NM", "New Mexico"],
      ["NV", "Nevada"],
      ["NY", "New York"],
      ["OH", "Ohio"],
      ["OK", "Oklahoma"],
      ["OR", "Oregon"],
      ["PA", "Pennsylvania"],
      ["PR", "Puerto Rico"],
      ["RI", "Rhode Island"],
      ["SC", "South Carolina"],
      ["SD", "South Dakota"],
      ["TN", "Tennessee"],
      ["TX", "Texas"],
      ["UT", "Utah"],
      ["VA", "Virginia"],
      ["VI", "Virgin Islands"],
      ["VT", "Vermont"],
      ["WA", "Washington"],
      ["WI", "Wisconsin"],
      ["WV", "West Virginia"],
      ["WY", "Wyoming"]
    ]

    cells = states.map do |state_a|
        { title: state_a[1], action: :visit_state, arguments: { state: state_a[0] }}
    end

    [{
      title: "States",
      cells: cells
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

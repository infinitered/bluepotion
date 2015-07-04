class ExampleXmlScreen < PMScreen
  xml_layout :example_xml_screen
  title "Example XML Screen"
  action_bar true, back: true

  def on_load
    find(:left_button).on(:tap) do
      app.toast("Left button clicked")
    end
    find(:right_button).on(:tap) do
      open ExampleTableScreen, people: ["Todd", "Darin", "Gant", "Jamon"], test_int: 123, test_symbol: :my_symbol
    end
  end
end

class ExampleXmlScreen < PMScreen

  # If you are using XML for this screen:
  #uses_xml :example_xml

  uses_action_bar true
  stylesheet ExampleXmlScreenStylesheet

  # Title is unnecesary if you're using an XML file
  title "Your title here"

  # This is optional, it will default to a RelativeView or use your XML file
  #def load_view
    #Potion::LinearLayout.new(self.activity)
  #end

  def on_load
    append(Potion::TextView, :hello_label)
  end
end

class <%= @name_camel_case %>Screen < PMScreen

  # If you are using XML for this screen:
  #uses_xml :xml_file_name
  #xml_widgets :some_widget
  #xml_fragments :some_fragment

  uses_action_bar true
  title "Your title here"
  stylesheet <%= @name_camel_case %>ScreenStylesheet

  # This is optional, it will default to a RelativeView
  #def load_view
    #Potion::LinearLayout.new(self.activity)
  #end

  def on_load
    append(Potion::TextView, :hello_label)
  end
end

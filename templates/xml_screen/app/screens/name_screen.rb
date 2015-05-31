class <%= @name_camel_case %>Screen < PMScreen
  uses_xml :<%= @name %>_screen
  uses_action_bar true
  stylesheet <%= @name_camel_case %>ScreenStylesheet

  def on_load
  end
end

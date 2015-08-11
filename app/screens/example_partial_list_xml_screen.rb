class ExamplePartialListXML < PMListScreen
  xml_layout :embedded_listview
  title "View with a ListView Inside"

  def on_load
    mp "ExamplePartialListXML on_load"
  end

  def add_adapter
    find!(:some_internal_listview).adapter = adapter
  end

  def table_data
    [{
      title: "Regular Listview inside XML",
      cells: [{
        title: "I'm a Regular Cell"
      }]
    }]
  end

end

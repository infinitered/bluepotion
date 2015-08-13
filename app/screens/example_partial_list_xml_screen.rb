class ExamplePartialListXML < PMListScreen
  refreshable
  xml_layout :embedded_listview
  title "View with a ListView Inside"

  def table_data
    [{
      cells: buncho_cells
    }]
  end


  private

  def buncho_cells
    array_of_cells = []
    100.times do |i|
      array_of_cells << {title: "Here's cell #{i}"}
    end
    array_of_cells
  end

end

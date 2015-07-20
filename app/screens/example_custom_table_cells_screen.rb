# AKA a list with custom views
class ExampleCustomTableCellsScreen < PMListScreen
  stylesheet ExampleCustomTableCellsScreenStylesheet
  title "Example Custom Table Cells"

  def load_view
    mp "ExampleTableScreen load_view"
    Potion::ListView.new(self.activity)
  end

  def table_data
    [{
      title: "BluePotion Developers",
      cells: [
        { title: "Gant", action: :view_developer, arguments: { state: "oregon" }},
        { title: "Todd", action: :view_developer, arguments: { state: "washington" }}
      ]
    }]
  end

  def view_developer options
    mp options
  end
end
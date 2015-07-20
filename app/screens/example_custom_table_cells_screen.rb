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
      cells: [{
        title: "Gant",
        cell_class: ImageCell,
        properties: {image: "taco"},
        action: :view_developer,
        arguments: { github: "GantMan" }
      },{
        title: "Todd",
        cell_class: ImageCell,
        properties: {image: "taco"},
        action: :view_developer,
        arguments: { github: "twerth" }
      }]
    }]
  end

  def view_developer(args, position)
    mp args
  end
end
class HomeScreen < PMScreen

  stylesheet HomeScreenStylesheet

  def on_load
    root = rmq.append(Potion::LinearLayout, :root)

    text = root.rmq_append!(Potion::TextView, :text_view)
    text.text = "Hello BluePotion!"

    #root.rmq_append(Potion::Button, :button).on(:tap) do |sender|
      #Potion::Toast.makeText(activity, "Drink your potion.", Potion::Toast::LENGTH_SHORT).show()
    #end
  end

end

class HomeScreen < PMScreen

  #stylesheet HomeScreenStylesheet

  def on_load
    mp "Starting"
    #mp rmq
    #root = rmq.append(Potion::LinearLayout, :root)
    #root = rmq.append(Potion::TextView, :text_view)

    $o = self
    #$o = root
    #text = root.append!(Potion::TextView, :text_view)
    #text.text = "Hello BluePotion!"

    #root.append(Potion::Button, :button)
    #.on(:tap) do |sender|
      #Potion::Toast.makeText(activity, "Drink your potion.", Potion::Toast::LENGTH_SHORT).show()
    #end
  end



end

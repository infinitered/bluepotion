class HomeScreen < PMScreen

  #stylesheet HomeScreenStylesheet

  def on_load
    mp "Starting"
    #mp rmq
    #root = rmq.append(Potion::LinearLayout, :root)
    #root = rmq.append(Potion::TextView, :text_view)

    $o = self

    create_some_test_views

    #$o = root
    #text = root.append!(Potion::TextView, :text_view)
    #text.text = "Hello BluePotion!"

    #root.append(Potion::Button, :button)
    #.on(:tap) do |sender|
      #Potion::Toast.makeText(activity, "Drink your potion.", Potion::Toast::LENGTH_SHORT).show()
    #end
  end

  def create_some_test_views
    # $o.create_some_test_views

    # In activity
    rmq.activity.rmq.append(Potion::View)
    rmq.activity.rmq.append(Potion::View)
    rmq.activity.rmq.append(Potion::View)
    rmq.activity.rmq.append(Potion::View)
    rmq.activity.rmq.append(Potion::View)
    rmq.activity.rmq.append(Potion::AbsoluteLayout).append(Potion::View)

    # In screen
    #rmq.append(Potion::View)
    #rmq.append(Potion::View)
    #rmq.append(Potion::View)
    #rmq.append(Potion::View)
    #rmq.append(Potion::View)
    #rmq.append(Potion::AbsoluteLayout).append(Potion::View)
    #rmq.append(Potion::AbsoluteLayout).append(Potion::View).append(Potion::View)
  end



end

class HomeScreen < PMScreen

  stylesheet HomeScreenStylesheet

  # This will automatically set to a FrameLayout if you don't override this method
  def load_view
    Potion::LinearLayout.new(self.activity)
  end

  def on_load
    mp "Starting"

    text = rmq.append(Potion::TextView).get
    text.text = "Hello BluePotion!"

    # Debugging
    $o = self
    #create_some_test_views
    rmq.log_tree

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
    rmq.append(Potion::View)
    rmq.append(Potion::View)
    rmq.append(Potion::View)
    rmq.append(Potion::AbsoluteLayout).tap do |q|
      q.append(Potion::View)
      q.append(Potion::View)
      q.append(Potion::View)
      rmq.append(Potion::AbsoluteLayout).tap do |q2|
        q2.append(Potion::View)
      end
    end
  end

end

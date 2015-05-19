class HomeScreen < PMScreen

  stylesheet HomeScreenStylesheet

  # This will automatically set to a FrameLayout if you don't override this method
  def load_view
    Potion::FrameLayout.new(self.activity)
  end

  def on_load
    mp "Starting"

    append_view(Potion::TextView, :text_view).data("Hello BluePotion!")

    append_view(Potion::Button, :button).on(:tap) do |sender|
      Potion::Toast.makeText(find.activity, "Drink your potion.", Potion::Toast::LENGTH_SHORT).show()
    end

    # Debugging
    $o = self
    #create_some_test_views
    rmq.log_tree

  end

  def create_some_test_views
    # $o.create_some_test_views

    # In activity
    rmq.activity.rmq.append_view(Potion::View)
    rmq.activity.rmq.append_view(Potion::View)
    rmq.activity.rmq.append_view(Potion::View)
    rmq.activity.rmq.append_view(Potion::View)
    rmq.activity.rmq.append_view(Potion::View)
    rmq.activity.rmq.append_view(Potion::AbsoluteLayout).append_view(Potion::View)

    # In screen
    rmq.append_view(Potion::View)
    rmq.append_view(Potion::View)
    rmq.append_view(Potion::View)
    rmq.append_view(Potion::AbsoluteLayout).tap do |q|
      q.append_view(Potion::View)
      q.append_view(Potion::View)
      q.append_view(Potion::View)
      rmq.append_view(Potion::AbsoluteLayout).tap do |q2|
        q2.append_view(Potion::View)
      end
    end
  end

end

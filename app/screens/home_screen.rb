class HomeScreen < PMScreen

  uses_action_bar true
  stylesheet HomeScreenStylesheet
  title "BluePotion Home"

  # This will automatically set to a RelativeLayout if you don't override this method
  def load_view
    mp "HomeScreen load_view"

    #Potion::LinearLayout.new(self.activity)
    Potion::FrameLayout.new(self.activity)
  end

  def on_load
    mp "HomeScreen on_load"

    append_view(Potion::TextView,  :hello_label).data("Hello BluePotion!")
    append_view(Potion::ImageView, :logo)

    append_view(Potion::Button, :drink_button).on(:tap) do |sender|
      Potion::Toast.makeText(find.activity, "Drink your potion.", Potion::Toast::LENGTH_SHORT).show
    end

    append_view(Potion::Button, :open_example_table_button).on(:tap) do |sender|
      open ExampleTableScreen
    end

    debug
  end

  def debug
    $o = self
    create_some_test_views
    rmq.activity.rmq.log_tree
  end

  def create_some_test_views
    # $o.create_some_test_views

    # In activity
    rmq.activity.rmq.append_view(Potion::View)
    rmq.activity.rmq.append_view(Potion::View)
    rmq.activity.rmq.append_view(Potion::View)
    rmq.activity.rmq.append_view(Potion::View).tag(:foo, :bar)
    rmq.activity.rmq.append_view(Potion::View)
    rmq.activity.rmq.append_view(Potion::AbsoluteLayout).append_view(Potion::View)

    # In screen
    rmq.append_view(Potion::View)
    rmq.append_view(Potion::View).tag(:foo)
    rmq.append_view(Potion::View).tag(:foo)
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

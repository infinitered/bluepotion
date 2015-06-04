class HomeScreen < PMScreen

  uses_action_bar true
  stylesheet HomeScreenStylesheet
  title "BluePotion Home"

  # This will automatically set to a RelativeLayout if you don't override this method
  def load_view
    mp "HomeScreen load_view", debugging_only: true

    Potion::LinearLayout.new(self.activity)
    #Potion::FrameLayout.new(self.activity)
    #Potion::RelativeLayout.new(self.activity)
  end

  def on_load
    mp "HomeScreen on_load", debugging_only: true

    append(Potion::ImageView, :logo)

    append(Potion::TextView,  :hello_label).data("Hello BluePotion!").on(:tap) do 
      PotionDialog.new(xml_layout: R::Layout::Alert_dialog, width: 700, height: 1200)
    end


    append(Potion::Button, :drink_button).on(:tap) do |sender|
      Potion::Toast.makeText(find.activity, "Drink your potion.", Potion::Toast::LENGTH_SHORT).show
    end

    append(Potion::Button, :open_example_table_button).on(:tap) do |sender|
      open ExampleTableScreen, people: ["Todd", "Darin", "Gant", "Jamon"]
    end

    append(Potion::CalendarView, :calendar)

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
    rmq.activity.rmq.append(Potion::View)
    rmq.activity.rmq.append(Potion::View)
    rmq.activity.rmq.append(Potion::View)
    rmq.activity.rmq.append(Potion::View).tag(:foo, :bar)
    rmq.activity.rmq.append(Potion::View)
    rmq.activity.rmq.append(Potion::AbsoluteLayout).append(Potion::View)

    # In screen
    rmq.append(Potion::View)
    rmq.append(Potion::View).tag(:foo)
    rmq.append(Potion::View).tag(:foo)
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

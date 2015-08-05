class HomeScreen < PMScreen
  title "BluePotion Home"
  stylesheet HomeScreenStylesheet
  action_bar true, icon: true, back: false

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

    append(Potion::TextView,  :hello_label).data("Hello BluePotion!")

    append(Potion::Button, :drink_button).on(:tap) do |sender|
      show_weather_in_sf
    end

    append(Potion::Button, :dialog_button).on(:tap) do |sender|
      PotionDialog.new(xml_layout: app.resource.layout(:blue_potion_dialog), w: 500, h: 500)
    end

    append(Potion::Button, :xml_button).on(:tap) do |sender|
      open ExampleXmlScreen
    end

    append(Potion::Button, :open_example_table_button).on(:tap) do |sender|
      open ExampleTableScreen, people: ["Todd", "Darin", "Gant", "Jamon"], test_int: 123, test_symbol: :my_symbol
    end

    append(Potion::Button, :open_example_custom_cells).on(:tap) do
      open ExampleCustomTableCellsScreen
    end

    append(Potion::Button, :countdown_button).on(:tap) do |sender|
      original_text = sender.text
      sender.enabled = false
      app.async do |task|
        5.times do |i|
          task.progress(5 - i)
          sleep 1
        end
      end.on(:progress) do |count|
        sender.text = "     #{count}      "
      end.on(:completion) do
        sender.text = original_text
        sender.enabled = true
      end
    end

    append(Potion::Button, :benchmarks_button).on(:tap) do
      run_benchmarks
    end

    #append(Potion::CalendarView, :calendar)

    debug
  end

  #def foo(a, b)
    #bar a, b
  #end

  #def bar(c, d)
    #c + d
  #end

  def run_benchmarks
    mp "\nRunning bencharks ----------------------"

    #p = Potion::View.new
    #p = nil
    #Potion::System.gc

    #total = 0
    #h = {}
    ##a = [1,2]
    #0.upto(100000) do |i|
      #mp i
      ##h[i] = RMQ.new
      ##a.each{}
    #end

    #mp 'done'
      #h[i] = {}
      #h.each do |k,v|
        #a = nil
      #end
      #h[i] = nil #{i: i} #, a: {i: i}, b: {i: i}, c: {i: i}}
      #total += foo(i, 2)
    #end

    #total = 0
    #Benchmark.run_single("", "test", 100000) do
      #total += foo(1, 2)
    #end

    #mp total
    #mp 'done'

    #return

    iterations = 100
    benchmark = Benchmark

    benchmark.run_single("", "nothing", iterations) do
    end

    benchmark.run_single("", "find(:benchmarks_button).length", iterations) do
      find(:benchmarks_button).length
    end

    root_view = find.root_view
    benchmark.run_single("root_view = find.root_view", "root_view.find(:benchmarks_button).length", iterations) do
      root_view.find(:benchmarks_button).length
    end

    root_view_q = find(find.root_view)
    benchmark.run_single("root_view_q = find(find.root_view)", "root_view_q.find(:benchmarks_button).length", iterations) do
      root_view_q.find(:benchmarks_button).length
    end

    root_view_q = find(find.root_view)
    benchmark.run_single("root_view_q = find(find.root_view)", "root_view_q.find(:benchmarks_button).length", iterations) do
      root_view_q.find(:benchmarks_button).length
    end

    q = find(Potion::AbsoluteLayout).first
    q.children.first.tag(:ab_layout_child)
    benchmark.run_single("q = find(Potion::AbsoluteLayout).first; q.children.first.tag(:ab_layout_child)", "q.find(:ab_layout_child).length", iterations) do
      q.find(:ab_layout_child).length
    end

    #app.toast out
  end

  def show_weather_in_sf
    url = "http://openweathermap.org/data/2.1/find/name"
    app.net.get_json(url, q: "san francisco") do |response|
      $r = response
      if response.success?
        temp_kelvin = response.object["list"].first["main"]["temp"]
        f = (((temp_kelvin - 273.15) * 1.8000) + 32).to_i
        out = "The weather is #{f} degrees"
        app.toast(out)
      end
    end
  end

  def debug
    $o = self
    create_some_test_views
    #rmq.activity.rmq.log_tree
  end

  def create_some_test_views
    # $o.create_some_test_views

    # In activity
    find.activity.rmq.append(Potion::View)
    find.activity.rmq.append(Potion::View)
    find.activity.rmq.append(Potion::View)
    find.activity.rmq.append(Potion::View).tag(:foo, :bar)
    find.activity.rmq.append(Potion::View)
    find.activity.rmq.append(Potion::AbsoluteLayout).append(Potion::View)

    # In screen
    append(Potion::View)
    append(Potion::View).tag(:foo)
    append(Potion::View).tag(:foo)
    append(Potion::AbsoluteLayout).tap do |q|
      q.append(Potion::View)
      q.append(Potion::View)
      q.append(Potion::View)
      q.append(Potion::AbsoluteLayout).tap do |q2|
        q2.append(Potion::View)
      end
    end
  end

end

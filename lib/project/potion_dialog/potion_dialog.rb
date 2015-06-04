class PotionDialog

  def initialize(options)
    # err if missing required options
    raise "Requires an xml_layout!!" unless options[:xml_layout]
    raise "Cannot have width without height!!" if options[:width] && !options[:height]
    raise "Cannot have height without width!!" if options[:height] && !options[:width]
    
    # Merging defaults    
    opts = { 
      title: false, 
      show: true
    }.merge(options)

    built_dialog = build_dialog(opts)

    built_dialog.show if opts[:show]

    built_dialog
  end

  def build_dialog(options)
    # create dialog
    dialog = Potion::Dialog.new(rmq.app.current_activity)

    # manage title
    if options[:title] 
      dialog.title = options[:title]
    else
      dialog.requestWindowFeature(Potion::Window::FEATURE_NO_TITLE)
    end

    # set alert content
    dialog.setContentView(options[:xml_layout])

    # set width and height of Dialog Window
    if options[:height] && options[:width]
      dialog.window.setLayout(options[:width], options[:height])
    end 
    dialog
  end
end
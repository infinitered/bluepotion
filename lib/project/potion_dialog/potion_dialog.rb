class PotionDialog

  def initialize(options)

    @width = options[:width] || options[:w]
    @height = options[:height] || options[:h]

    # err if missing required options
    raise "[BluePotion ERROR] PotionDialog#initialize Requires an xml_layout" unless options[:xml_layout]
    raise "[BluePotion ERROR] PotionDialog#initialize Cannot have width without height" if @width && !@height
    raise "[BluePotion ERROR] PotionDialog#initialize Cannot have height without width" if @height && !@width    
    
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
    dialog = Potion::Dialog.new(find.activity)

    # manage title
    if options[:title] 
      dialog.title = options[:title]
    else
      dialog.requestWindowFeature(Potion::Window::FEATURE_NO_TITLE)
    end

    # set alert content
    dialog.setContentView(options[:xml_layout])

    # set width and height of Dialog Window
    if @width && @height
      dialog.window.setLayout(@width, @height)
    end 
    dialog
  end
end
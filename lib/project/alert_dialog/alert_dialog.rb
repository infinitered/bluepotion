######################################################
# Example usage - since this is in PMApplication
######################################################
# app.alert(title: "Hey There", message: "Want a sandwich?") do |choice|
#   case choice
#   when "OK"
#     mp "Here's your sandwich"
#   when "Cancel"
#     mp "Fine!"
#   end
# end
#
# Example of alert with input
# app.alert(title: "What's your name?", style: :input) do |choice, input_text|
#  mp "User clicked #{choice} and typed #{input_text}"
# end

# Generic AlertDialog
class AlertDialog < Android::App::DialogFragment

  def initialize(options={}, &block)

    # Defaults
    @options = {
      theme: Android::App::AlertDialog::THEME_HOLO_LIGHT,
      title: "Alert!",
      message: nil,
      positive_button: "OK",
      negative_button: "Cancel",
      positive_button_handler: self,
      negative_button_handler: self,
      style: nil,
      show: true
    }.merge(options)

    @callback = block

    self.show if @options[:show]
    self
  end

  def show(activity=rmq.activity)
    super(activity.fragmentManager, "alert_dialog")
  end

  def onCreateDialog(saved_instance_state)
    builder = Android::App::AlertDialog::Builder.new(activity, @options[:theme])

    builder.title = @options[:title]
    builder.message = @options[:message]

    # Add buttons if they are set
    builder.setPositiveButton(@options[:positive_button], @options[:positive_button_handler]) if @options[:positive_button]
    builder.setNegativeButton(@options[:negative_button], @options[:negative_button_handler]) if @options[:negative_button]

    # Add custom view?
    @options[:view] = simple_text_view if @options[:style] == :input
    builder.view = @options[:view] if @options[:view]

    # DONE!
    builder.create
  end

  def simple_text_view
    # Set up the input
    input = Potion::EditText.new(activity)
    input.singleLine = true
    input.id = @text_view_id = Potion::ViewIdGenerator.generate
    input.inputType = Android::Text::InputType.const_get(@options[:type]) if @options.key?(:type)
    input
  end

  def onClick(dialog, id)
    button_text = (id == Android::App::AlertDialog::BUTTON_POSITIVE) ? @options[:positive_button] : @options[:negative_button]

    # if a text_view is present, grab what the user gave us
    text_view = @text_view_id && dialog.findViewById(@text_view_id)
    input_text = text_view ? text_view.text.toString : nil

    @callback.call(button_text, input_text) if @callback
  end

end

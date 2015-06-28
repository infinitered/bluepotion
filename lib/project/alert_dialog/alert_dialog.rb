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

# Generic AlertDialog
class AlertDialog < Android::App::DialogFragment

  def initialize(options={}, &block)

    # Defaults
    @options = {
      theme: Android::App::AlertDialog::THEME_HOLO_LIGHT,
      title: "Alert!",
      message: "",
      positive_button: "OK",
      negative_button: "Cancel",
      positive_button_handler: self,
      negative_button_handler: self,
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
    builder = Android::App::AlertDialog::Builder.new(getActivity(), @options[:theme])

    builder.title = @options[:title]
    builder.message = @options[:message]

    # Add buttons if they are set
    builder.setPositiveButton(@options[:positive_button], @options[:positive_button_handler]) if @options[:positive_button]
    builder.setNegativeButton(@options[:negative_button], @options[:negative_button_handler]) if @options[:negative_button]

    # Add custom view?
    builder.view = @options[:view] if @options[:view]

    # DONE!
    builder.create()
  end

  def onClick(dialog, id)
    button_text = (id == Android::App::AlertDialog::BUTTON_POSITIVE) ? @options[:positive_button] : @options[:negative_button]
    @callback.call(button_text) if @callback
  end

end

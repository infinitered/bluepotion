###### EXAMPLE USAGE #######
#@phud = ProgressHUD.new("Loading Widgets")
#@phud.show
#@phud.title = "Widgets Almost Completed!"
#@phud.dismiss

class ProgressHUD < Android::App::DialogFragment

  def initialize(title="Loading")
    @title = title
  end

  def show(activity=rmq.activity)
    super(activity.fragmentManager, "progress")
  end

  def onCreateDialog(saved_instance_state)
    builder = Android::App::AlertDialog::Builder.new(activity,
      Android::App::AlertDialog::THEME_HOLO_LIGHT)

    progress = Android::Widget::ProgressBar.new(activity)
    progress.setBackgroundColor(Android::Graphics::Color::TRANSPARENT)
    builder.setView(progress)
           .setTitle(@title)

    @created_dialog = builder.create()
  end

  def title=(new_title)
    @created_dialog.title = new_title if @created_dialog
  end

  def hide
    self.dismiss
  end
  alias_method :close, :hide

end

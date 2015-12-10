###### EXAMPLE USAGE #######
#@phud = ProgressHUD.new("Loading Widgets")
#@phud.show
#@phud.title = "Widgets Almost Completed!"
#@phud.dismiss

class ProgressHUD < Android::App::DialogFragment

  def initialize(title="Loading", opts={})
    @title = title
    @style = convert_style(opts[:style])
    @max = opts[:max]
  end

  def show(activity=rmq.activity)
    super(activity.fragmentManager, "progress")
  end

  def onCreateDialog(saved_instance_state)
    builder = Android::App::AlertDialog::Builder.new(activity,
      Android::App::AlertDialog::THEME_HOLO_LIGHT)

    if @style
      @progress = Android::Widget::ProgressBar.new(activity, nil, @style)
      if @max
        @progress.setIndeterminate(false)
        @progress.setMax(@max)
      end
    else
      @progress = Android::Widget::ProgressBar.new(activity)
    end
    @progress.setBackgroundColor(Android::Graphics::Color::TRANSPARENT)
    builder.setView(@progress)
        .setTitle(@title)

    @created_dialog = builder.create()
  end

  def progress=(value)
    @progress.setProgress(value)
  end

  def increment(inc=1)
    runnable = HudRun.new
    @current_progress ||= 0
    @current_progress += inc
    runnable.progress = @current_progress
    runnable.hud = self

    # 99.99% of the time, we will use this from within app.async
    # so we need to be sure to run the progress in the UI thread
    activity.runOnUiThread(runnable)
  end

  def title=(new_title)
    @created_dialog.title = new_title if @created_dialog
  end

  def hide
    self.dismiss
  end
  alias_method :close, :hide

  protected
  def convert_style(style)
    return nil if style.nil?

    case style
      when :horizontal
        Android::R::Attr::ProgressBarStyleHorizontal
      else
        style
    end
  end

end

class HudRun
  attr_accessor :hud, :progress

  def run
    hud.progress = progress
  end

end
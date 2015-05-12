class RubyMotionQueryStylesheet

  def initialize
    unless RubyMotionQueryStylesheet.application_was_setup
      RubyMotionQueryStylesheet.application_was_setup = true
      application_setup
    end
    setup
  end

  def application_setup
    # Override to do your overall setup for your applications. This
    # is where you want to add your custom fonts and colors
    # This only gets called once
  end

  def setup
    # Override if you need to do setup in your specific stylesheet
  end

  def color
    RMQ.color
  end

  def font
    RMQ.font
  end

  def apply_style_to_view(view, style_name)
    styler = styler_for(view)
    stylesheet.send(style_name, styler)
    styler.finalize
  end

  def styler_for(view)
    case view
    when Android::Widget::RelativeLayout  then StylersRelativeLayoutStyler.new(view, context)
    when Android::Widget::LinearLayout    then StylersLinearLayoutStyler.new(view, context)
    when Android::Widget::TextView        then StylersTextViewStyler.new(view, context)
    when Android::Widget::ImageView       then StylersImageViewStyler.new(view, context)
    when Android::Widget::ImageButton     then StylersImageButtonStyler.new(view, context)
    when Android::Widget::Button          then StylersButtonStyler.new(view, context)
    else
      StylersViewStyler.new(view, context)
    end
  end

  class << self
    attr_accessor :application_was_setup
  end



end

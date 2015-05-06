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

  class << self
    attr_accessor :application_was_setup
  end

end

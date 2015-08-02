class RMQStylesheet
  def initialize(parent_screen)
    unless RMQStylesheet.application_was_setup
      RMQStylesheet.application_was_setup = true
      application_setup
    end
    @screen = parent_screen
    setup
  end

  # @ deprecated
  def controller=(value)
    @screen = value
  end
  # @ deprecated
  def controller
    @screen
  end

  def screen
    @screen
  end

  def find(*working_selectors) # Not calling rmq below for performance reasons (one less method invocation)
    if @screen
      @screen.rmq(working_selectors)
    else
      super
    end
  end
  def rmq(*working_selectors)
    if @screen
      @screen.rmq(working_selectors)
    else
      super
    end
  end

  def application_setup
    # Override to do your overall setup for your applications. This
    # is where you want to add your custom fonts and colors
    # This only gets called once
  end

  def setup
    # Override if you need to do setup in your specific stylesheet
  end

  def color(*params)
    RMQ.color(*params)
  end

  def font
    rmq.font
  end

  def image
    rmq.image
  end

  class << self
    attr_accessor :application_was_setup
  end

end

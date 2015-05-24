abort "RMQStylesheet"
class RMQStylesheet
  attr_accessor :controller

  def initialize(controller)
    unless RMQStylesheet.application_was_setup
      RMQStylesheet.application_was_setup = true
      application_setup
    end
    @controller = controller
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

class MainActivity < Android::App::Activity
  def onCreate(savedInstanceState)
    super
    @text = Android::Widget::TextView.new(self)
    @text.text = 'Hello Android!'
    @text.textColor = Android::Graphics::Color::WHITE
    @text.textSize = 40.0
    self.contentView = @text
  end

end

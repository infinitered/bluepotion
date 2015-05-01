class FakeAndroidStuff
  class << self
    def views
      @_views ||= [
        View.new(:style_a),
        ButtonView.new(:button_style_a),
        View.new(:style_b),
        View.new(:style_c)
      ]
    end

    def root_view
      rview = View.new(:root_view)
      self.views.each do |view|
        rview.append view
      end

      rview
    end
  end
end

class Window
end

class Activity
  def getWindow
    Window.new
  end

end

class Fragment
end

class ViewGroup
end

class View
  attr_accessor :style_name, :subviews, :superview

  def initialize(style_name)
    @style_name = style_name
    @subviews = []
  end

  def append(view)
    view.superview = self
    @subviews << view
  end
end

class ButtonView < View
end

class LabelView < View
end


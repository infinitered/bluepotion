module Potion
  View = Android::View::View
  ViewGroup = Android::View::ViewGroup
  Element = Android::View::ViewGroup

  # widgets
  LinearLayout = Android::Widget::LinearLayout
  RelativeLayout = Android::Widget::RelativeLayout
  TextView = Android::Widget::TextView
  ImageView = Android::Widget::ImageView
  Button = Android::Widget::Button
  Toast = Android::Widget::Toast

  # graphics
  Color = Android::Graphics::Color
  Typeface = Android::Graphics::Typeface
end

#
# Android's generateViewId method was implemented in API leve 17 - for older devices we need to
# roll our own solution.
#
# This is apparently Android's implementation from View.java, according to:
# http://stackoverflow.com/questions/1714297/android-view-setidint-id-programmatically-how-to-avoid-id-conflicts
class Potion::ViewIdGenerator

  @current_id = Java::Util::Concurrent::Atomic::AtomicInteger.new(1)

  def self.generate
    while true do
      result = @current_id.get
      # aapt-generated IDs have the high byte nonzero; clamp to the range under that.
      new_value = result + 1
      if new_value > 0x00FFFFFF
        new_value = 1
      end
      if @current_id.compareAndSet(result, new_value)
        return result
      end
    end
  end

end

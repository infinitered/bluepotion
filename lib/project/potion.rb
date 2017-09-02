module Potion
  Activity = Android::App::Activity
  Intent = Android::Content::Intent
  View = Android::View::View
  Window = Android::View::Window
  ViewGroup = Android::View::ViewGroup
  Integer = Java::Lang::Integer
  ArrayList = Java::Util::ArrayList
  Bundle = Android::Os::Bundle
  Environment = Android::Os::Environment
  Uri = Android::Net::Uri
  Url = Java::Net::URL
  ArrayAdapter = Android::Widget::ArrayAdapter
  BaseAdapter = Android::Widget::BaseAdapter
  Dialog = Android::App::Dialog
  EditorInfo = Android::View::Inputmethod::EditorInfo
  System = Java::Lang::System
  DecimalFormat =	Java::Text::DecimalFormat
  Collections =	Java::Util::Collections

  # Layouts
  LayoutInflater = Android::View::LayoutInflater
  LinearLayout = Android::Widget::LinearLayout
  FrameLayout = Android::Widget::FrameLayout
  RelativeLayout = Android::Widget::RelativeLayout
  AbsoluteLayout = Android::Widget::AbsoluteLayout

  # Widgets
  Label = Android::Widget::TextView
  TextView = Android::Widget::TextView
  EditText = Android::Widget::EditText
  ImageView = Android::Widget::ImageView
  Button = Android::Widget::Button
  CalendarView = Android::Widget::CalendarView
  Toast = Android::Widget::Toast
  ListView = Android::Widget::ListView
  ScrollView = Android::Widget::ScrollView

  # Graphics
  Color = Android::Graphics::Color
  Typeface = Android::Graphics::Typeface
  Bitmap = Android::Graphics::Bitmap

  # Media
  File = Java::Io::File
  FileOutputStream = Java::Io::FileOutputStream
  MediaStore = Android::Provider::MediaStore
  Contacts = Android::Provider::ContactsContract::Contacts
  # This is needed since you can't access constants of interfaces
  # Basically is Android::Provider::MediaStore::Images::Media::INTERNAL_CONTENT_URI
  INTERNAL_CONTENT_URI = Potion::Uri.parse("content://media/internal/images/media")
  PHONE_CONTENT_URI = Potion::Uri.parse("content://com.android.contacts/data/phones")

  Handler = Android::Os::Handler
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

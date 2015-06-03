# http://developer.android.com/reference/android/text/TextWatcher.html
# there seems to be a bug with this particular interface - subclassing this class works around it
# http://community.rubymotion.com/t/how-to-use-textwatcher-to-listen-to-changes-of-an-edittext/522
class RMQTextChange < Android::Telephony::PhoneNumberFormattingTextWatcher
  attr_accessor :change_block

  def initialize(action=:after, &block)
    @action = action
    @change_block = block
  end

  def onTextChanged(s, start, before, count)
    @change_block.call(s, start, before, count) if @action == :on
  end

  def beforeTextChanged(s, start, count, after)
    @change_block.call(s, start, count, after) if @action == :before
  end

  def afterTextChanged(s)
    @change_block.call(s) if @action == :after
  end

end
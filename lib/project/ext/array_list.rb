class Java::Util::ArrayList

  # REMOVE when RubyMotion adds this
  def uniq
    if self.length <= 1
      self
    else
      h = {}
      self.each do |el|
        h[el] = nil
      end
      h.keys
    end
  end

  # REMOVE when RubyMotion adds this
  def uniq!
    # This was failing with an array of views, TODO, check
    out = self.uniq
    self.clear
    self.addAll out
    self
  end

end

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
    out = self.uniq
    self.clear
    self.addAll out
    self
  end

  # REMOVE when RubyMotion adds this
  def flatten!
    out = self.flatten
    self.clear
    self.addAll out
    self
  end
end

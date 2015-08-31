class Symbol
  def <(value)
    self.to_s < value.to_s
  end
  def >(value)
    self.to_s > value.to_s
  end
end

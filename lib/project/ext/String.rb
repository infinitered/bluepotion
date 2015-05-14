class String
  def ljust(number_of_characters)
    if self.length < number_of_characters
      out = " " * (number_of_characters - self.length)
      out << self
      out
    else
      self
    end
  end

  def rjust(number_of_characters)
    if self.length < number_of_characters
      out = self
      out << " " * (number_of_characters - self.length)
      out
    else
      self
    end
  end
end

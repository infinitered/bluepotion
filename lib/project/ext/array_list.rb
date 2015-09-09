class Java::Util::ArrayList

  # REMOVE when RubyMotion adds this
  # Updated for 4.0 to always return a new object.  This oddly seems to matter as things HipByte
  # seems to have aggressively updated their JNI reference cleanups.
  def uniq
    h = {}
    self.each do |el|
      h[el] = nil
    end
    h.keys
  end

  # REMOVE when RubyMotion adds this
  def uniq!
    # This was failing with an array of views, TODO, check
    out = self.uniq
    self.clear
    self.addAll out
    self
  end

  def sort
    self.dup.insertionsort!
  end

  def sort!
    insertionsort!
    self
  end

  def sort_with(&block)
    self.dup.insertionsort!(&block)
  end

  def sort_with!(&block)
    insertionsort!(&block)
    self
  end

  # TODO I'm sure this is slow, haven't tested perf
  def insertionsort!(&block)
    1.upto(length - 1) do |i|
      value = self[i]
      j = i - 1
      while j >= 0 && (block ? block.call(self[j], value) : self[j] > value)
        self[j+1] = self[j]
        j -= 1
      end
      self[j+1] = value
    end
    self
  end

  # TODO: This fails in RMA over a certain size
  def quicksort
    h, *t = self
    if h
      t.partition{|a| a < h}.inject { |l, r| l.quicksort + [h] + r.quicksort }
    else
      []
    end
  end
end

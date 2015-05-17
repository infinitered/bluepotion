class RMQ
  # I'm purposly not including Enumerable,
  # please use to_a if you want one


  # @return [RMQ]
  def <<(value)
    selected << value if value.is_a?(UIView)
    self
  end

  # @return [RMQ]
  #
  # @example
  #   rmq(UILabel)[3]
  #   or
  #   rmq(UILabel)[1..5]
  #   or
  #   rmq(UILabel)[2,3]
  def [](*args)
    RMQ.create_with_array_and_selectors(Array(selected[*args]), @selectors, @originated_from)
  end
  alias :eq :[]

  # @return [RMQ]
  def each(&block)
    return self unless block
    RMQ.create_with_array_and_selectors(selected.each(&block), @selectors, @originated_from)
  end

  # @return [RMQ]
  def map(&block)
    return self unless block
    RMQ.create_with_array_and_selectors(selected.map(&block), @selectors, @originated_from)
  end
  alias :collect :map

  # @return [RMQ]
  def select(&block)
    return self unless block
    RMQ.create_with_array_and_selectors(selected.select(&block), @selectors, @originated_from)
  end

  # @return [RMQ]
  def detect(&block) # Unlike enumerable, detect and find are not the same. See find in transverse
    return self unless block
    RMQ.create_with_array_and_selectors(selected.select(&block), @selectors, @originated_from)
  end

  # @return [RMQ]
  def grep(&block)
    return self unless block
    RMQ.create_with_array_and_selectors(selected.grep(&block), @selectors, @originated_from)
  end

  # @return [RMQ]
  def reject(&block)
    return self unless block
    RMQ.create_with_array_and_selectors(selected.reject(&block), @selectors, @originated_from)
  end

  # @return [RMQ]
  def inject(o, &block)
    return self unless block
    RMQ.create_with_array_and_selectors(selected.inject(o, &block), @selectors, @originated_from)
  end
  alias :reduce :inject

  # @return [RMQ]
  def first
    # TODO, check if it fails with nil
    RMQ.create_with_array_and_selectors([selected.first], @selectors, @originated_from)
  end
  # @return [RMQ]
  def last
    # TODO, check if it fails with nil
    RMQ.create_with_array_and_selectors([selected.last], @selectors, @originated_from)
  end

  # @return [Array]
  def to_a
    selected
  end

  # @return [Integer] number of views selected
  def length
    selected.length
  end
  def size
    length
  end
  def count
    length
  end
  #alias :size :length
  #alias :count :length
end



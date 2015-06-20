class Dispatch
  class << self
    def once(&block)
      block.call
    end
  end
end

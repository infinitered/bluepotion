class RMQ
  def self.caching_enabled?
    !!@caching_enabled
  end

  def self.caching_enabled=(value)
    @caching_enabled = value
  end
end

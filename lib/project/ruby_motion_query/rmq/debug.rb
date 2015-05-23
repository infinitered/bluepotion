class RMQ
  def self.debugging?
    @debugging ||= ENV['rmq_debug'] == 'true'
  end

  def self.debugging=(flag)
    @debugging = flag
  end
end

class RMQScreenData
  attr_accessor :stylesheet, :cached_rmq

  def cleanup
    @cached_rmq = nil
    @stylesheet = nil
  end
end

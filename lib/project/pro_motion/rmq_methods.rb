module RMQMethods

  # RM-724
  def rmq_append(view_class, style=nil, opts={})
    rmq.rmq_append(view_class, style, opts)
  end

  def rmq_append!(view_class, style=nil, opts={})
    rmq.rmq_append!(view_class, style, opts)
  end

end

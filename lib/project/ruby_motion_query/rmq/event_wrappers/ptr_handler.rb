class PTRHandler
  def initialize(&block)
    @refresh_callback = block
  end

  def checkCanDoRefresh(frame, content, header)
    !content.canScrollVertically(-1)
  end

  def onRefreshBegin(frame)
    @refresh_callback.call(frame)
  end
end
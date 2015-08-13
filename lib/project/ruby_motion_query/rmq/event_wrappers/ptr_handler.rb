class PtrHandler
  def initialize(&block)
    @refresh_callback = block
  end

  def checkCanDoRefresh(frame, content, header)
    true
  end

  def onRefreshBegin(frame)
    @refresh_callback.call(frame)
  end
end
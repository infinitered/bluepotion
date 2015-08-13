# SHould be included in PMListScreen but RMA is acting up
module RefreshableList

  def make_refreshable(params={})
    @ptr = find!(In::Srain::Cube::Views::Ptr::PtrFrameLayout)
    header = In::Srain::Cube::Views::Ptr::Header::MaterialHeader.new(app.context)
    ptr_colors = params[:color_array] || [color.dark_gray]
    header.setColorSchemeColors(ptr_colors)
    header.setPtrFrameLayout(@ptr)
    @ptr.setHeaderView(header)
    @ptr.addPtrUIHandler(header)
    @ptr.ptrHandler = PtrHandler.new do |frame|
      # should call on_refresh if respond_to?(:on_refresh)
      frame.refreshComplete
    end
  end

  def self.refreshable(params = {})
    @refreshable_params = params
    @refreshable = true
  end

  def self.get_refreshable
    @refreshable ||= false
  end

  def self.get_refreshable_params
    @refreshable_params ||= nil
  end

  def stop_refreshing
    @ptr.refreshComplete
  end

end
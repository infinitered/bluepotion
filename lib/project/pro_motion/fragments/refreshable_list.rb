module RefreshableList

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def refreshable(params = {})
      @refreshable_params = params
      @refreshable = true
    end

    def get_refreshable
      @refreshable ||= false
    end

    def get_refreshable_params
      @refreshable_params ||= nil
    end
  end

  def make_refreshable(params={})
    @ptr = find!(In::Srain::Cube::Views::Ptr::PtrFrameLayout)
    header = In::Srain::Cube::Views::Ptr::Header::MaterialHeader.new(app.context)
    ptr_colors = params[:color_array] || [color.dark_gray]
    header.setColorSchemeColors(ptr_colors)
    header.setPtrFrameLayout(@ptr)
    @ptr.setHeaderView(header)
    @ptr.addPtrUIHandler(header)
    @ptr.ptrHandler = PTRHandler.new do |frame|
      on_refresh if respond_to?(:on_refresh)
    end
  end

  def stop_refreshing
    @ptr.refreshComplete
  end

end

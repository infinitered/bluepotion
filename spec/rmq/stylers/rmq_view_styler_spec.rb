describe 'RMQViewStyler' do
  describe 'visibility' do

    before do
      @view = Potion::View.new(RMQ.app.context)
      @styler = RMQViewStyler.new(@view, RMQ.app.context)
    end

    it 'should support true' do
      @styler.visibility = true
      @view.getVisibility.should == Android::View::View::VISIBLE
    end

    it 'should support :visible' do
      @styler.visibility = :visible
      @view.getVisibility.should == Android::View::View::VISIBLE
    end

    it 'should support :invisible' do
      @styler.visibility = :invisible
      @view.getVisibility.should == Android::View::View::INVISIBLE
    end

    it 'should support false' do
      @styler.visibility = false
      @view.getVisibility.should == Android::View::View::INVISIBLE
    end

    it 'should support :gone' do
      @styler.visibility = :gone
      @view.getVisibility.should == Android::View::View::GONE
    end

    it 'should support the alias visible' do
      @styler.visible = :gone
      @view.getVisibility.should == Android::View::View::GONE
    end

  end
end

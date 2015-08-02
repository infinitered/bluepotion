describe 'subviews' do
  before do
    #@home_screen = rmq.screen
    #@screen = @home_screen.open(PMScreen)
    @screen = PMScreen.new
    #@screen.view = rmq.create(Potion::FrameLayout).cleanup.get
    @root_view = Potion::AbsoluteLayout.new
    @screen.view = @root_view
  end

  after do
    #@screen.close
  end

  #it 'should append a view to the root_view' do
    #sleep 10
    #view = @root_view.rmq.append(Potion::View).get
    #@root_view.getChildCount.should == 1
    #@root_view.getChildAt(0).should == view
  #end

  #it 'should append a view to a screen' do
    #view = @screen.rmq.append(Potion::View).get
    #@screen.view.getChildCount.should == 1
    #@screen.view.getChildAt(0).should == view
  #end
end

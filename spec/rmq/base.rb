# Used throughout the specs
#def hash_to_subviews(parent_view, hash, new_hash = {}, view_name = nil)
  #return unless parent_view && hash.length > 0

  #hash.each do |k,v|
    #if k == :klass
      #o = parent_view.append(v).get
      #new_hash[view_name] = {
        #name: view_name,
        #view: o,
        ##view: nil,
        #subs: {}
      #}
    #elsif k == :subs
      #hash_to_subviews(new_hash[view_name][:view], v, new_hash[view_name][:subs])
    #else
      #hash_to_subviews(parent_view, v, new_hash, k)
    #end
  #end

  #new_hash
#end

class TestScreen < PMScreen
  title "Test Screen"
  #stylesheet HomeScreenStylesheet
  #action_bar true, icon: true, back: false

  def on_load
  end
end


describe 'base' do
  before do
    #@activity = PMActivity.new
    #@activity.open_fragment @screen
    #@screen = TestScreen.new
    #@screen = PMActivity.new
    #@screen = TestScreen.new
    #@screen.load_view
    #@root_view = @screen.view
    #mp @root_view.inspect
    #@screen.view = rmq.create(Potion::FrameLayout).cleanup.get
    @screen = TestScreen.new
    @root_view = Potion::FrameLayout.new
    @screen.view = @root_view
  end

  it 'should create simplest' do
    RMQ.new.should.not == nil

    #main_activity.activity_init
    #main_activity.open_fragment @screen
    #mp main_activity.inspect
    #mp main_activity.find.screen.inspect
    #mp find.activity.inspect
  end

  it 'should have root_view setup in "before"' do
    @screen.view.should == @root_view
  end

  it 'should return rmq object with both screen.rmq and screen.find' do
    @screen.rmq.is_a?(RMQ).should == true
    @screen.find.is_a?(RMQ).should == true
  end

  it 'should return rmq object with both @root_view.rmq and @root_view.find' do
    @root_view.rmq.is_a?(RMQ).should == true
    @root_view.find.is_a?(RMQ).should == true
  end

  it 'set originated_from and get originated_from' do
    rmq = RMQ.new
    screen = PMScreen.new

    rmq.originated_from = screen
    rmq.originated_from.should == screen
  end

  it 'set parent_rmq and get parent_rmq' do
    rmq = RMQ.new
    rmq2 = RMQ.new

    rmq.parent_rmq = rmq2
    rmq.parent_rmq.should == rmq2
  end

  it 'should set selectors with an array of views and return that array' do
    a = [0..4].map do |i|
      Potion::View.new
    end

    rmq = RMQ.new
    rmq.originated_from = a.first
    rmq.selected = a
    rmq.selected.should == a
  end

  it 'setting selectors should reset selected' do
    a = [0..4].map do |i|
      Potion::View.new
    end

    rmq = RMQ.new
    rmq.originated_from = a.first
    rmq.selected = a
    rmq.selected.should == a

    view = a.first
    rmq.selectors = [view]
    rmq.selected.should == [view]
  end

  describe 'should wrap' do
    before do
      #@screen = UIViewController.alloc.init
      #@my_view = @screen.rmq.append(Potion::View).get
      #@my_view_2 = @screen.rmq.append(Potion::View).get
    end

    #it 'screen should have 2 children' do
      #@screen.rmq.children.length.should == 2
    #end

    #it 'a view(s) in an existing view tree with a new rmq instance' do
      #q = RMQ.new
      #q.wrap(Potion::View).length.should == 0
      #q.wrap(@my_view).length.should == 1
      #q.wrap(@my_view, @my_view_2).length.should == 2
      #q.wrap(@my_view).siblings.get.should == @my_view_2
      #q.wrap(@my_view).view_controller.should == @screen
    #end

    #it 'a view with its screen\'s rmq' do
      #@screen.rmq.wrap(Potion::View).length.should == 0
      #@screen.rmq.wrap(@my_view).length.should == 1
      #@screen.rmq.wrap(@my_view, @my_view_2).length.should == 2
      #@screen.rmq.wrap(@my_view).siblings.get.should == @my_view_2
      #@screen.rmq.wrap(@my_view).view_controller.should == @screen

      ## Identical to this:
      #@screen.rmq(@my_view).length.should == 1
      #@screen.rmq(@my_view, @my_view_2).length.should == 2
      #@screen.rmq(@my_view).siblings.get.should == @my_view_2
      #@screen.rmq(@my_view).view_controller.should == @screen

      ## But this will be different because it selects all UIViews
      #@screen.rmq(Potion::View).length.should != 0
    #end

    it 'a view not in a view tree with a new rmq instance' do
      q = RMQ.new
      my_view_3 = Potion::View.new
      q.wrap(Potion::View).length.should == 0
      q.wrap(my_view_3).length.should == 1
      q.wrap(my_view_3).siblings.length.should == 0
    end

  end

end

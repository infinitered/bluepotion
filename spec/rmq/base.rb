# Used throughout the specs
def hash_to_subviews(parent_view, hash, new_hash = {}, view_name = nil)
  return unless parent_view && hash.length > 0

  hash.each do |k,v|
    if k == :klass
      o = parent_view.append(v).get
      new_hash[view_name] = {
        name: view_name,
        view: o,
        #view: nil,
        subs: {}
      }
    elsif k == :subs
      hash_to_subviews(new_hash[view_name][:view], v, new_hash[view_name][:subs])
    else
      hash_to_subviews(parent_view, v, new_hash, k)
    end
  end

  new_hash
end

describe 'base' do

  it 'should create simplest' do
    RMQ.new.should.not == nil
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

end

# Used throughout the specs
def hash_to_subviews(view, hash, new_hash = {}, view_name = nil)
  mp 2
  return unless view && hash.length > 0
  mp 3
  mp hash

  hash.each do |k,v|
    mp 3.5
    if k == :klass
      mp 4
      o = rmq.create(k)
      view.append o
      new_hash[view_name] = {
        name: view_name,
        view: o,
        subs: {}
      }
    elsif k == :subs
      mp 5
      hash_to_subviews(new_hash[view_name][:view], v, new_hash[view_name][:subs])
    else
      mp 6
      hash_to_subviews(view, v, new_hash, k)
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

describe 'traversing' do
  before do
    #@vc = PMScreen.new
    #v = @vc.rmq.create(Potion::FrameLayout).get
    #@vc.view = v
    #@root_view = v

    ##@views_hash = {
      ##v_0: {
        ##klass: Potion::FrameLayout,
        ##subs: {
          ##v_0: {
            ##klass: Potion::FrameLayout,
            ##subs: {
              ##v_0: { klass: Potion::View, subs: { } },
              ##v_1: { klass: Potion::View, subs: { } },
              ##v_2: { klass: Potion::View, subs: { } },
              ##v_3: { klass: Potion::View, subs: { } }
            ##}
          ##},
          ##v_1: { klass: Potion::View, subs: { } },
          ##v_2: { klass: Potion::View, subs: { } },
          ##v_3: { klass: Potion::View, subs: { } },
          ##v_4: { klass: Potion::View, subs: { } }
        ##}
      ##},
    ##}

    #@views_hash = {
      #v_0: {
        #klass: Potion::FrameLayout,
        #subs: {
          #v_0: {
            #klass: Potion::FrameLayout,
            #subs: {
              #v_0: { klass: Potion::View, subs: { } },
              #v_1: { klass: Potion::ImageView, subs: { } },
              #v_2: { klass: Potion::View, subs: { } },
              #v_3: { klass: Potion::TextView, subs: { } }
            #}
          #},
          #v_1: { klass: Potion::TextView, subs: { } },
          #v_2: { klass: Potion::View, subs: { } }
        #}
      #},
      #v_1: { klass: Potion::TextView, subs: { } },
      #v_2: { klass: Potion::TextView, subs: { } },
      #v_3: {
        #klass: Potion::FrameLayout,
        #subs: {
          #v_0: { klass: Potion::View, subs: { } },
          #v_1: { klass: Potion::View, subs: { } },
          #v_2: {
            #klass: Potion::FrameLayout,
            #subs: {
              #v_0: { klass: Potion::FrameLayout,
                #subs: {
                  #v_0: { klass: Potion::TextView, subs: { } },
                  #v_1: { klass: Potion::View, subs: { } },
                  #v_2: { klass: Potion::ImageView, subs: { } }
                #}
              #}
            #}
          #}
        #}
      #}
    #}

    #@views_hash = hash_to_subviews(@root_view, @views_hash)
    ##@v0 = @views_hash[:v_0][:view]
    ##@v3_v2_v0 = @views_hash[:v_3][:subs][:v_2][:subs][:v_0][:view]
    ##@last_image = @views_hash[:v_3][:subs][:v_2][:subs][:v_0][:subs][:v_2][:view]
    ##@total_views = 18
  end

  #it 'locate view given view' do
    ##q = @vc.rmq(@last_image)
    ##q.length.should == 1
    ##q.get.should == @last_image
    #1.should == 1
  #end

end

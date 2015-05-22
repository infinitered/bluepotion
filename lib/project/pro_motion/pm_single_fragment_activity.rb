# An abstract Activity designed to host a single fragment.
# RM-733
#module ProMotion
  class PMSingleFragmentActivity < PMActivity
    attr_accessor :fragment_container, :fragment

    EXTRA_FRAGMENT_CLASS = "fragment_class"

    def onCreate(saved_instance_state)
      mp "PMSingleFragmentActivity onCreate"
      super

      @fragment_container = Android::Widget::FrameLayout.new(self)

      @fragment_container.setId Potion::ViewIdGenerator.generate
      self.contentView = @fragment_container

      if (fragment_class = intent.getStringExtra(EXTRA_FRAGMENT_CLASS))
        # TODO weird way to create this intance, look at this later
        set_fragment Kernel.const_get(fragment_class.to_s).new
      end

      self.on_create saved_instance_state
    end

    def on_create
      raise "on_create is a required abstract method"
    end

    def set_fragment(fragment)
      @fragment = fragment # useful for the REPL
      fragmentManager.beginTransaction
        .add(@fragment_container.getId, fragment, fragment.class.to_s)
        .commit
    end

  end
#end

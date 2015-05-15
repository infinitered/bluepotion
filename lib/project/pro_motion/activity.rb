# http://hipbyte.myjetbrains.com/youtrack/issue/RM-773 - can't put this in a module yet :(
#module ProMotion

  class PMActivity < Android::App::Activity

    def onCreate(saved_instance_state)
      puts "PMActivity onCreate"
      super

      if self.class.rmq_style_sheet_class
        self.rmq.stylesheet = self.class.rmq_style_sheet_class
        self.view.rmq.apply_style(:root_view) if self.rmq.stylesheet.respond_to?(:root_view)
      end

      #rmq.app.context
    end

    def onResume
      super
      PMApplication.current_activity = self
    end

    def onPause
      clear_references
      super
    end

    def onDestroy
      clear_references
      super
    end

    def clear_references
    end

    def self.stylesheet(style_sheet_class)
      @rmq_style_sheet_class = style_sheet_class
    end

    def self.rmq_style_sheet_class
      @rmq_style_sheet_class
    end

  end

  #class PMActivity < Android::App::Activity
    #def foo
      #1
    #end
  #end


  #class PMActivity < Android::App::Activity
    #def bar
      #2
    #end
  #end


#end

# http://hipbyte.myjetbrains.com/youtrack/issue/RM-773 - can't put this in a module yet :(
#module ProMotion

  class PMActivity < Android::App::Activity

    def onCreate saved_instance_state
      super
      @app = self.getApplicationContext
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
      @app.current_activity = nil if @app.current_activity == self
    end

    def rmq(*working_selectors)
      crmq = RMQ.create_with_selectors([], self)

      if working_selectors.length == 0
        crmq
      else
        RMQ.create_with_selectors(working_selectors, self, crmq)
      end
    end
    alias :find :rmq

    def root_element
      getWindow.getDecorView.findViewById(Android::R::Id::Content)
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

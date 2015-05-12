class Object
  def rmq(*working_selectors)
    if (app = RubyMotionQuery::RMQ.app) && (window = app.window) && (cvc = app.current_activity)
      cvc.rmq(working_selectors)
    else
      RubyMotionQuery::RMQ.create_with_array_and_selectors([], working_selectors, self)
    end
  end
end

#class PMActivity < Android::App::Activity
  #def rmq(*working_selectors)
    #crmq = RubyMotionQuery::RMQ.create_with_selectors([], self) # TODO

    #if working_selectors.length == 0
      #crmq
    #else
      #RubyMotionQuery::RMQ.create_with_selectors(working_selectors, self, crmq)
    #end
  #end
#end

#class PMScreen < Android::App::Fragment
#end

class Window
end

class ViewGroup
end

class View
  #def rmq_data
    #@_rmq_data ||= RubyMotionQuery::ViewData.new
  #end

  def rmq_created
  end

  # Override this to build your view and view's subviews
  def rmq_build
  end

  def rmq_appended
  end

  def rmq_style_applied
  end

  # Technically my_view.rmq is the same as rmq(my_view), so it may seem enticing to use,
  # but the really nice thing about rmq is its consistent API, and doing this
  # for one view: my_view.rmq and this for two views: rmq(my_view, my_other_view) sucks
  def rmq(*working_selectors)
    RMQ.create_with_selectors(working_selectors, self).tap do |o|
      #if vc = self.rmq_data.view_controller
        #o.weak_view_controller = vc
      #end
    end
  end
end

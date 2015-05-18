class RMQ
  def activity
    # TODO we can get the activity in better ways, and in more
    # situations
    if @originated_from.is_a?(PMScreen)
      @originated_from.activity
    elsif @originated_from.is_a?(Potion::Activity)
      @originated_from
    elsif @originated_from.is_a?(Potion::View)
      if @originated_from.rmq_data
        @originated_from.rmq_data.activity
      else
        RMQApp.current_activity
      end
    else
      RMQApp.current_activity
    end
  end

  def screen
    # TODO we can get the screen in better ways, and in more
    # situations
    if @originated_from.is_a?(PMScreen)
      @originated_from
    elsif @originated_from.is_a?(Potion::View)
      if @originated_from.rmq_data
        @originated_from.rmq_data.screen
      else
        RMQApp.current_screen
      end
    else
      RMQApp.current_screen
    end
  end

  def controller
    self.screen || self.activity
  end

  def root_view
    self.controller.root_view
  end

  def filter(opts = {}, &block)
    out = []
    limit = opts[:limit]

    selected.each do |view|
      results = yield(view)
      unless RMQ.is_blank?(results)
        out << results
        break if limit && (out.length >= limit)
      end
    end
    out.flatten!
    out = out.uniq if opts[:uniq]

    if opts[:return_array]
      out
    else
      RMQ.create_with_array_and_selectors(out, selectors, @originated_from, self)
    end
  end

  def all
    wrap(root_view).find
  end

  def children(*working_selectors)
    normalize_selectors(working_selectors)

    filter do |view|
      sbvws = view.subviews

      if RMQ.is_blank?(working_selectors)
        sbvws
      else
        sbvws.inject([]) do |out, subview|
          out << subview if match(subview, working_selectors)
          out
        end
      end
    end
  end
  alias :subviews :children

  def find(*working_selectors)

    normalize_selectors(working_selectors)

    filter(uniq: true) do |view|
      sbvws = all_subviews_for(view)


      if RMQ.is_blank?(working_selectors)
        sbvws
      else
        sbvws.inject([]) do |out, subview|
          out << subview if match(subview, working_selectors)
          out
        end
      end
    end # filter

  end
end

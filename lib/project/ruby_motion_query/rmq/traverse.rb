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
        RMQ.app.current_activity
      end
    else
      RMQ.app.current_activity
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
        RMQ.app.current_screen
      end
    else
      RMQ.app.current_screen
    end
  end

  def controller
    self.screen || self.activity
  end

  def root_view
    if @originated_from.is_a?(Android::App::Activity)
      @originated_from.root_view
    else
      self.controller.root_view
    end
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
    #mp 2
    normalize_selectors(working_selectors)

    self_selected = self.selected
    if working_selectors.length == 1 && self_selected.length == 1
      single_selected = self_selected[0]
      #if single_seleced.rmq_data.cache_queries
      single_selector = working_selectors[0]
      #if single_selector.is_a?(Symbol)
        if cached = single_selected.rmq_data.query_cache[single_selector]
          #mp "cached #{single_selector}"
          return cached
        else
          q = filter(uniq: true) do |view|
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

          single_selected.rmq_data.query_cache[single_selector] = q
          return q
        end
      #end
    end

    # Repeating this inline for performance, TODO, measure and refactor
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

  def find!(*args) # Do not alias this, strange bugs happen where classes don't have methods
    self.find(*args).get
  end

  # @return [RMQ] A new rmq instance reducing selected views to those that match selectors provided
  #
  # @param selectors your selector
  #
  # @example
  #   rmq(UIImage).and(:some_tag).attr(image: nil)
  def and(*working_selectors)
    return self unless working_selectors
    normalize_selectors(working_selectors)

    self.select do |view|
      match(view, working_selectors)
    end
  end

  # @return [RMQ] A new rmq instance removing selected views that match selectors provided
  #
  # @param selectors
  #
  # @example
  #   # Entire family of labels from siblings on down
  #   rmq(my_label).parent.find(UILabel).not(my_label).move(left: 10)
  def not(*working_selectors)
    return self unless working_selectors
    normalize_selectors(working_selectors)

    self.reject do |view|
      match(view, working_selectors)
    end
  end

  # @return [RMQ] A new rmq instance adding the context to the selected views
  #
  # @example
  #   rmq(my_view).children.and_self
  def and_self
    if self.parent_rmq
      out = self.parent_rmq.selected.dup
      out << selected
      out.flatten!
      RMQ.create_with_array_and_selectors(out, selectors, @context, self)
    else
      self
    end
  end
  alias :add_self :and_self

  # @return [RMQ] The parent rmq instance. This is useful when you want to go down
  # into the tree, then move back up to do more work. Like jQuery's "end"
  #
  # @example
  #   rmq(test_view).find(Potion::Button).tag(:foo).back.find(UILabel).tag(:bar)
  def back
    self.parent_rmq || self
  end

  # @return [RMQ] rmq instance selecting the parent of the selected view(s)
  #
  # @example
  #   rmq(my_view).parent.find(:delete_button).toggle_enabled
  def parent
    closest(Potion::View)
  end
  alias :superview :parent

  # @return [RMQ] Instance selecting the parents, grandparents, etc, all the way up the tree
  # of the selected view(s)
  #
  # @param selectors
  #
  # @example
  #   rmq(my_view).parents.log
  def parents(*working_selectors)
    normalize_selectors(working_selectors)

    filter(uniq: true) do |view|
      superviews = all_superviews_for(view)

      if RMQ.is_blank?(working_selectors)
        superviews
      else
        superviews.inject([]) do |subview, out|
          out << subview if match(subview, working_selectors)
          out
        end
      end
    end
  end
  alias :superviews :parents

  # @return [RMQ] Siblings of the selected view(s)
  #
  # @param selectors
  #
  # @example
  #   rmq(my_view).siblings.send(:poke)
  def siblings(*working_selectors)
    normalize_selectors(working_selectors)

    self.parent.children.not(selected)
  end

  # @return [RMQ] Sibling below the selected view(s) (in the subview array)
  #
  # @param selectors
  #
  # @example
  #   rmq(my_view).next.hide
  #   rmq(my_view).next(UITextField).focus
  def next(*working_selectors)
    normalize_selectors(working_selectors)

    filter do |view|
      subs = view.superview.subviews
      location = subs.index(view)
      if location < subs.length - 1
        subs[location + 1]
      end
    end
  end

  # @return [RMQ] Sibling above the selected view(s) (in the subview array)
  #
  # @param selectors
  #
  # @example
  #   rmq(my_view).prev.hid
  #   rmq(my_view).prev(UITextField).focus
  def prev(*working_selectors)
    normalize_selectors(working_selectors)

    filter do |view|
      if sv = view.superview
        subs = sv.subviews
        location = subs.index(view)
        if location > 0
          subs[location - 1]
        end
      end
    end
  end

  # For each selected view, get the first view that matches the selector(s) by testing the view's parent and
  # traversing up through its ancestors in the tree
  #
  # @return [RMQ] Instance selecting the first parent or grandparent or ancestor up the tree of the selected view(s)
  #
  # @param selectors
  #
  # @example
  #   rmq.closest(Potion::View).get.setContentOffset([0,0])
  def closest(*working_selectors)
    normalize_selectors(working_selectors)

    filter do |view|
      closest_view(view, working_selectors)
    end
  end


  protected

  def closest_view(view, working_selectors)
    if nr = view.superview
      if match(nr, working_selectors)
        nr
      else
        closest_view(nr,working_selectors)
      end
    else
      nil
    end
  end

end

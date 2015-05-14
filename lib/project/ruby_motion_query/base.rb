# mq.wrap(rmq.root_element).find(ButtonView)
  class RMQ
    #attr_accessor :view
    #attr_accessor :stylesheet
    #attr_accessor :context

    def initialize
      @selected_dirty = true
    end

    def originated_from=(value)
      if value
        #if value.is_a?(Activity)
          #@originated_from = RubyMotionQuery::RMQ.weak_ref(value)
        #elsif value.is_a?(View)
          @originated_from = value
        #else
          #debug.log_detailed('Invalid originated_from', objects: {value: value})
        #end
      else
        @originated_from = nil
      end
      @originated_from
    end

    def originated_from
      @originated_from
    end

    def parent_rmq
      @_parent_rmq
    end
    def parent_rmq=(value)
      #debug.assert(value.is_a?(RMQ) || value.nil?, 'Invalid parent_rmq', { value: value })
      @_parent_rmq = value
    end

    # Do not use
    def selected=(value)
      @_selected = value
      @selected_dirty = false
    end

    def root?
      (selected.length == 1) && (selected.first == @originated_from)
    end

    def originated_from_or_its_view
      if @originated_from.is_a?(Activity)
        @originated_from.view
      else
        @originated_from
      end
    end

    def get
      # work-in-progress
      return view

      sel = self.selected
      if sel.length == 1
        sel.first
      else
        sel
      end
    end

    def origin_views
      if pq = self.parent_rmq
        pq.selected
      else
        root_element
      end
    end

    def wrap(*views)
      views.flatten!
      views.select!{ |v| v.is_a?(View) } # TODO Fake view here
      RMQ.create_with_array_and_selectors(views, views, views.first, self)
    end

    def log(opt = nil)
      if opt == :tree
        puts tree_to_s(selected)
        return
      end

      wide = (opt == :wide)
      out =  "\n id   | class                 | style_name              | frame                           |"
      out << "\n" unless wide
      out <<   " sv id       | superelement             | subelements count          | tags                            |"
      line =   " - - - - - - | - - - - - - - - - - - | - - - - - - - - - - - - | - - - - - - - - - - - - - - - - |\n"
      out << "\n"
      out << line.chop if wide
      out << line

      selected.each do |element|
        out << " #{element.id.to_s.ljust(12)}|"
        out << " #{element.class.name[0..21].ljust(22)}|"
        #out << " #{(element.style_name || '')[0..23].ljust(24)}|" # TODO change to real stylname

        s = ""
        #if element.origin
          #format = '#0.#'
          #s = " {l: #{RMQ.format.numeric(element.origin.x, format)}"
          #s << ", t: #{RMQ.format.numeric(element.origin.y, format)}"
          #s << ", w: #{RMQ.format.numeric(element.size.width, format)}"
          #s << ", h: #{RMQ.format.numeric(element.size.height, format)}}"
        #end
        out << s.ljust(33)
        out << '|'

        out << "\n" unless wide
        #out << " #{element.superelement.id.to_s.ljust(12)}|"
        #out << " #{(element.superelement ? element.superelement.class.name : '')[0..21].ljust(22)}|"
        #out << " #{element.subelement.length.to_s.ljust(23)} |"
        #out << "  #{element.subelement.length.to_s.rjust(8)} #{element.superelement.class.name.ljust(20)} #{element.superelement.id.to_s.rjust(10)}"
        #out << " #{element.rmq_data.tag_names.join(',').ljust(32)}|"
        out << "\n"
        out << line unless wide
      end

      out << "RMQ #{self.id}. #{self.count} selected. selectors: #{self.selectors}"

      puts out
    end

    def tree_to_s(selected_elements, depth = 0)
      out = ""

      selected_elements.each do |view|

        if depth == 0
          out << "\n"
        else
          0.upto(depth - 1).each do |i|
            out << (i == (depth - 1) ? '    ├' : '    │')
          end
        end

        out << '───'

        out << " #{element.class.name[0..21]}"
        out << "  ( #{element.style_name[0..23]} )" if element.style_name
        out << "  #{element.id}"
        #out << "  [ #{element.rmq_data.tag_names.join(',')} ]" if element.rmq_data.tag_names.length > 0

        #if element.origin
          #format = '#0.#'
          #s = "  {l: #{RMQ.format.numeric(element.origin.x, format)}"
          #s << ", t: #{RMQ.format.numeric(element.origin.y, format)}"
          #s << ", w: #{RMQ.format.numeric(element.size.width, format)}"
          #s << ", h: #{RMQ.format.numeric(element.size.height, format)}}"
          #out << s
        #end

        out << "\n"
        out << tree_to_s(element.subelements, depth + 1)
      end

      out
    end

    def inspect
      out = "RMQ. #{self.count} selected. selectors: #{self.selectors}. .log for more info"
      #out = "RMQ #{self.id}. #{self.count} selected. selectors: #{self.selectors}. .log for more info"
      out << "\n[#{selected.first}]" if self.count == 1
      out
    end

    def selected
      if @selected_dirty
        @_selected = []

        if RMQ.is_blank?(self.selectors)
          @_selected << originated_from_or_its_view
        else
          working_selectors = self.selectors.dup
          extract_views_from_selectors(@_selected, working_selectors)

          unless RMQ.is_blank?(working_selectors)
            subviews = all_subviews_for(root_element)
            subviews.each do |subview|
              @_selected << subview if match(subview, working_selectors)
            end
          end

          @_selected.uniq!
        end

        @selected_dirty = false
      else
        @_selected ||= []
      end

      @_selected
    end

    def extract_views_from_selectors(view_container, working_selectors)
      unless RMQ.is_blank?(working_selectors)
        working_selectors.delete_if do |selector|
          if selector.is_a?(View)
            view_container << selector
            true
          end
        end
      end
    end

    def all_subviews_for(view)
      out = []
      if view.subviews
        view.subviews.each do |subview|
          out << subview
          out << all_subviews_for(subview)
        end
        out.flatten!
      end

      out
    end

    def all_superviews_for(view, out = [])
      if (sv = view.superview)
        out << sv
        all_superviews_for(sv, out)
      end
      out
    end

  end # RMQ

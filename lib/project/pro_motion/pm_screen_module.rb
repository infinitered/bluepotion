# http://hipbyte.myjetbrains.com/youtrack/issue/RM-773 - can't put this in a module yet :(
# module ProMotion
  module PMScreenModule
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      attr_reader :xml_resource
      attr_reader :xml_widget_ids
      attr_reader :show_action_bar

      @show_action_bar = true

      def stylesheet(style_sheet_class)
        @rmq_style_sheet_class = style_sheet_class
      end

      def rmq_style_sheet_class
        @rmq_style_sheet_class
      end

      def uses_xml(xml_resource=nil)
        @xml_resource = xml_resource ||= deduce_resource_id
      end

      def xml_widgets(*widget_ids)
        @xml_widget_ids = widget_ids || []
        @xml_widget_ids.each do |id|
          attr_accessor id
        end
      end

      def uses_action_bar(show_action_bar)
        @show_action_bar = show_action_bar
      end

      private

      def deduce_resource_id
        resource = self.name.split(".").last
        resource.underscore.to_sym
      end
    end

    def rmq_data
      @_rmq_data ||= RMQScreenData.new
    end

    def stylesheet
      self.rmq.stylesheet
    end

    def stylesheet=(value)
      self.rmq.stylesheet = value
    end

    def rmq(*working_selectors)
      crmq = (rmq_data.cached_rmq ||= RMQ.create_with_selectors([], self))

      if working_selectors.length == 0
        crmq
      else
        RMQ.create_with_selectors(working_selectors, self, crmq)
      end
    end

    def root_view
      self.getView
    end

    def on_load
      # abstract
    end

    def append_view(view_or_class, style=nil, opts={})
      self.rmq.append_view(view_or_class, style, opts)
    end

    def append_view!(view_or_class, style=nil, opts={})
      self.rmq.append_view(view_or_class, style, opts).get
    end

    # TODO add create and build


    # temporary stand-in for Java's R class
    def r(resource_type, resource_name)
      resources.getIdentifier(resource_name.to_s, resource_type.to_s,
                              activity.getApplicationInfo.packageName)
    end

    def show_toast(message)
      Android::Widget::Toast.makeText(activity, message, Android::Widget::Toast::LENGTH_SHORT).show
    end

    def open(screen_class, options={})
      mp "ScreenModule open"
      options[:activity] ||= PMSingleFragmentActivity
      # TODO: replace the fragment in the activity when possible
      # replace the fragment if we can; otherwise launch a new activity
      # we're taking a conservative approach for now - eventually we'll want to allow
      # replacing fragments for any kind of activity, but I'm not sure of the best way
      # to implement that yet
      intent = Android::Content::Intent.new(activity, options[:activity])
      intent.putExtra PMSingleFragmentActivity::EXTRA_FRAGMENT_CLASS, screen_class.to_s
      # TODO: limited support for extras for now - should reimplement with fragment arguments
      if options[:extras]
        options[:extras].keys.each do |key|
          intent.putExtra key.to_s, options[:extras][key].toString
        end
      end
      startActivity intent
    end

    def start_activity(activity_class)
      intent = Android::Content::Intent.new(activity, activity_class)
      startActivity(intent)
    end

    def soft_input_mode(mode)
      mode_const =
        case mode
        when :adjust_resize
          Android::View::WindowManager::LayoutParams::SOFT_INPUT_ADJUST_RESIZE
        end
      activity.getWindow().setSoftInputMode(mode_const)
    end

    def hide_keyboard
      input_manager = activity.getSystemService(Android::Content::Context::INPUT_METHOD_SERVICE)
      input_manager.hideSoftInputFromWindow(view.getWindowToken(), 0);
    end


    def activity
      getActivity()
    end

    def action_bar
      activity.getActionBar()
    end

  end
#end

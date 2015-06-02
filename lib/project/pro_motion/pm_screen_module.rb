# http://hipbyte.myjetbrains.com/youtrack/issue/RM-773 - can't put this in a module yet :(
# module ProMotion
  module PMScreenModule
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      attr_reader :xml_resource, :show_action_bar, :bars_title

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

      def uses_action_bar(show_action_bar)
        @show_action_bar = show_action_bar
      end

      def title(new_title)
        @bars_title = new_title
        #self.activity.title = new_title
        #getActivity().getActionBar().setTitle("abc")
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

    def color(*params)
      RMQ.color(*params)
    end

    def font
      rmq.font
    end

    def image
      rmq.image
    end

    def append(view_or_class, style=nil, opts={}, dummy=nil)
      self.rmq.append(view_or_class, style, opts)
    end

    def append!(view_or_class, style=nil, opts={})
      self.rmq.append(view_or_class, style, opts).get
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
      mp "ScreenModule open", debugging_only: true
      activity_class = options.delete(:activity) || PMSingleFragmentActivity

      # TODO: replace the fragment in the activity when possible
      # replace the fragment if we can; otherwise launch a new activity
      # we're taking a conservative approach for now - eventually we'll want to allow
      # replacing fragments for any kind of activity, but I'm not sure of the best way
      # to implement that yet
      intent = Android::Content::Intent.new(self.activity, activity_class)
      intent.putExtra PMSingleFragmentActivity::EXTRA_FRAGMENT_CLASS, screen_class.to_s

      if extras = options.delete(:extras)
        extras.keys.each do |key, value|
          # TODO, cahnge to bundle and do like below
          intent.putExtra key.to_s, value.toString
        end
      end

      unless options.blank?
        # The rest of the options are screen accessors, we use fragment arguments for this
        hash_bundle = PMHashBundle.from_hash(options)
        intent.putExtra PMSingleFragmentActivity::EXTRA_FRAGMENT_ARGUMENTS, hash_bundle.to_bundle
      end

      self.activity.startActivity intent
    end

    def close(options={})
      self.activity.finish
    end

    def start_activity(activity_class)
      intent = Android::Content::Intent.new(self.activity, activity_class)
      #intent.putExtra("key", value); # Optional parameters
      self.activity.startActivity(intent)
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

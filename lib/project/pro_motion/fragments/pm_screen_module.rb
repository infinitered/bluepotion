# http://hipbyte.myjetbrains.com/youtrack/issue/RM-773 - can't put this in a module yet :(
# module ProMotion
  module PMScreenModule
    def self.included(base)
      base.extend(ClassMethods)
    end


    module ClassMethods
      attr_reader :xml_resource, :bars_title

      def stylesheet(style_sheet_class)
        @rmq_style_sheet_class = style_sheet_class
      end

      def rmq_style_sheet_class
        @rmq_style_sheet_class
      end

      def xml_layout(xml_resource=nil)
        @xml_resource = xml_resource ||= deduce_resource_id
      end
      alias_method :uses_xml, :xml_layout

      # Sets up the action bar for this screen.
      #
      # Example:
      #   action_bar true, back: true, icon: true,
      #     custom_icon: "resourcename", custom_back: "custombackicon"
      #
      def action_bar(show_action_bar, opts={})
        @action_bar_options = ({show:true, back: true, icon: false}).merge(opts).merge({show: show_action_bar})
      end
      alias_method :nav_bar, :action_bar
      alias_method :uses_action_bar, :action_bar

      def action_bar_options
        @action_bar_options ||= action_bar(true, {})
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

    def onDestroy
      mp "onDestroy screen", debugging_only: true
      find.all.cleanup
      find.children.remove
      if @_rmq_data
        @_rmq_data.cleanup
        @_rmq_data = nil
      end
      super
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

    # abstract methods
    def on_load; end
    def on_return(opts={}); end

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

    def create(view_or_class, style=nil, opts={})
      self.rmq.create(view_or_class, style, opts)
    end

    def create!(view_or_class, style=nil, opts={})
      self.rmq.create(view_or_class, style, opts).get
    end

    def build(view_or_class, style=nil, opts={})
      self.rmq.build(view_or_class, style, opts)
    end

    def build!(view_or_class, style=nil, opts={})
      self.rmq.build(view_or_class, style, opts).get
    end

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

      if !options[:activity] && self.activity.respond_to?(:open_fragment)
        if screen_class.respond_to?(:new)
          screen = screen_class.new
        else
          screen = screen_class
        end
        self.activity.open_fragment screen, options
      else
        open_modal(screen_class, options)
      end
    end

    def open_modal(screen_class, options)
      activity_class = options.delete(:activity) || PMNavigationActivity
      activity_class = PMNavigationActivity if activity_class == :nav
      activity_class = PMSingleFragmentActivity if activity_class == :single

      intent = Potion::Intent.new(self.activity, activity_class)
      intent.putExtra PMActivity::EXTRA_FRAGMENT_CLASS, screen_class.to_s
      intent.setFlags(Potion::Intent::FLAG_ACTIVITY_CLEAR_TOP) if options.delete(:close)

      if extras = options.delete(:extras)
        extras.keys.each do |key, value|
          # TODO, cahnge to bundle and do like below
          intent.putExtra key.to_s, value.toString
        end
      end

      unless options.blank?
        # The rest of the options are screen accessors, we use fragment arguments for this
        hash_bundle = PMHashBundle.from_hash(options)
        intent.putExtra PMActivity::EXTRA_FRAGMENT_ARGUMENTS, hash_bundle.to_bundle
      end

      self.activity.startActivity intent
    end

    def close(options={})
      # Hang onto an activity reference, since we lose the activity
      act = self.activity

      if options[:activity] && options[:to_screen]
        # Closing to particular activity
        open options[:to_screen], activity: options[:activity], close: true
      elsif options[:to_screen]
        # Closing to particular fragment
        while act.fragment && !act.fragment.is_a?(options[:to_screen])
          act.close_fragment
          act.finish unless act.fragment
        end
      else
        # Closing current screen or activity if no screens left
        act.close_fragment if act.fragment
      end

      if act.fragment
        act.fragment.set_up_action_bar
        act.fragment.on_return(options)
      else
        act.finish unless act.fragment
      end
    end

    def start_activity(activity_class)
      intent = Potion::Intent.new(self.activity, activity_class)
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
      input_manager.hideSoftInputFromWindow(view.getWindowToken(), 0)
    end

    def show_keyboard
      field = activity.getCurrentFocus()
      input_manager = activity.getSystemService(Android::Content::Context::INPUT_METHOD_SERVICE)
      input_manager.showSoftInput(field, Android::View::InputMethod::InputMethodManager::SHOW_FORCED)
    end

    def action_bar
      activity && activity.getActionBar
    end

    def menu
      activity.menu
    end

    def set_up_action_bar(options={})
      if options[:show]
        action_bar.show
        action_bar.setDisplayHomeAsUpEnabled(!!options[:back])
        action_bar.setDisplayShowHomeEnabled(!!options[:icon])
        action_bar.setIcon(image.resource(options[:custom_icon].to_s)) if options[:custom_icon]
        action_bar.setHomeAsUpIndicator(image.resource(options[:custom_back].to_s)) if options[:custom_back]
      else
        action_bar.hide
      end
    end

    # Example: add_action_bar_button(title: "My text", show: :if_room)
    def add_action_bar_button(options={})
      @action_bar ||= { button_actions: {} }
      unless menu
        mp "#{self.inspect}#add_action_bar_button: No menu set up yet."
        return
      end

      options[:show] ||= :always

      # Should be something like Android::MenuItem::SHOW_AS_ACTION_IF_ROOM
      show_as_action = 0 if options[:show] == :never
      show_as_action = 1 if options[:show] == :if_room
      show_as_action = 2 if options[:show] == :always
      show_as_action = 4 if options[:show] == :with_text
      show_as_action = 8 if options[:show] == :collapse

      btn = self.activity.menu.add(options.fetch(:group, 0), options.fetch(:item_id, @action_bar[:current_id] || 0), options.fetch(:order, 0), options.fetch(:title, ""))
      btn.setShowAsAction(show_as_action) if show_as_action
      btn.setIcon(image.resource(options[:icon].to_s)) if options[:icon]
      @action_bar[:button_actions][btn.getItemId] = options[:action] if options[:action]
      @action_bar[:current_id] = btn.getItemId + 1
      btn
    end

    def on_options_item_selected(item)
      return unless @action_bar
      return unless method_name = @action_bar[:button_actions][item.getItemId]
      if respond_to?(method_name)
        send(method_name)
      else
        mp "#{self.inspect} No method #{method_name.inspect} implemented for this screen."
        true
      end
    end

    def build_and_tag_xml_views
      return unless @xml_resource

      self.rmq.all.each do |view|
        if ren = view.resource_entry_name
          self.rmq.build(view).tag(ren.to_sym)
        end
      end
    end

    def set_title
      self.title = self.class.bars_title
    end

    def title
      @title
    end
    def title=(value)
      @title = value

      if a = self.activity
        if a_bar = self.action_bar
          a_bar.title = value
        end
        a.title = value
      end
    end

  end
#end

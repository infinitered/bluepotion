# RM-773
#module ProMotion
  class PMApplication < Android::App::Application
    attr_accessor :context, :current_activity

    def onCreate
      mp "PMApplication onCreate", debugging_only: true

      # We can always get to the current application from PMApplication.current_application
      # but we set the child class's current_application too, in case someone uses that
      PMApplication.current_application = self
      self.class.current_application = self

      @context = self

      @home_screen_class = self.class.home_screen_class
      self.on_create if respond_to?(:on_create)
    end

    def home_screen_class
      @home_screen_class
    end

    def application_info
      context.applicationInfo
    end

    def package_manager
      context.getPackageManager
    end

    def name
      application_info.loadLabel(package_manager)
    end

    def identifier
      application_info.packageName
    end

    def package_name
      @package_name ||= application_info.packageName
    end

    def data_dir
      application_info.dataDir
    end

    def window
      if @current_activity
        @window ||= @current_activity.getWindow
      end
    end

    # Typically you don't use this, use `find.screen` instead, TODO, probably should remove this
    def current_screen
      if @current_activity && @current_activity.respond_to?(:fragment)
        @current_activity.fragment
      end
    end

    def guess_current_screen
      # TODO
      #ca.getFragmentManager.findFragmentById(Android::R::Id.fragment_container)
      #ca.getFragmentManager.frameTitle
    end

    # @return [Symbol] Environment the app is running it
    def environment
      @_environment ||= RUBYMOTION_ENV.to_sym
    end

    # @return [Boolean] true if the app is running in the :release environment
    def release?
      environment == :release
    end
    alias :production? :release?

    # @return [Boolean] true if the app is running in the :test environment
    def test?
      environment == :test
    end

    # @return [Boolean] true if the app is running in the :development environment
    def development?
      environment == :development
    end

    def resource
      RMQResource
    end

    def r
      RMQResource
    end

    def net
      BluePotionNet
    end

    def async(options={}, &block)
      MotionAsync.async(options, &block)
    end

    def toast(message, params={})
      message_length = case params[:length]
      when :long
        Android::Widget::Toast::LENGTH_LONG
      else
        Android::Widget::Toast::LENGTH_SHORT
      end
      Android::Widget::Toast.makeText(rmq.activity, message, message_length).show
    end

    def alert(options={}, &block)
      AlertDialog.new(options, &block)
    end

    # Send user to native Texting
    # app.sms("555-555-5555")
    def sms(phone_number)
      mp "[BP Deprecated] use app.launch(sms: #{phone_number}) over app.sms"
      launch(sms: phone_number)
    end

    # Launch native services via intent
    # app.launch(sms: '5045558008')
    # app.launch(web: 'http://giphy.com')
    # app.launch(email: 'your@mom.com')
    # app.launch(email: 'your@mom.com', subject: "Hey Chica", message: "Howdy")
    # app.launch(chooser: 'I hope you have a nice day!')
    def launch(command={})
      action_view = "android.intent.action.VIEW"
      action_send = "android.intent.action.SEND"
      launch_intent = case command.keys.first #TODO: fragile, re-evaluate
      when :sms
        sms_intent = Android::Content::Intent.new(action_view)
        sms_intent.setData(Android::Net::Uri.fromParts("sms", command[:sms].to_s, nil))
      when :email
        email_intent = Android::Content::Intent.new(action_view)
        email_string = "mailto:#{command[:email]}"
        email_string += "?subject=#{command[:subject].to_s}"
        email_string += "&body=#{command[:message].to_s}"
        email_intent.setData(Android::Net::Uri.parse(email_string))
      when :web
        web_intent = Android::Content::Intent.new(action_view)
        web_intent.setData(Android::Net::Uri.parse(command[:web]))
      when :chooser
        message_intent = Android::Content::Intent.new(action_send)
        message_intent.type = "text/plain"
        message_intent.putExtra("android.intent.extra.TEXT", command[:chooser].to_s) if command[:chooser]
        Android::Content::Intent.createChooser(message_intent, nil)
      else
        mp "[BP Warning] Unsupported launch type '#{command.keys.first}'"
      end

      find.activity.startActivity(launch_intent) if launch_intent
    end

    # Execute the given block after the given number of seconds
    #
    # @example
    # app.after(10) do
    #   p "This will print in 10 seconds"
    # end
    #
    def after(delay, &block)
      DelayedExecution.after(delay, &block)
    end

    class << self
      attr_accessor :current_application, :home_screen_class

      def home_screen(hclass)
        mp "PMApplication home_screen", debugging_only: true
        @home_screen_class = hclass
      end

    end
  end
#end

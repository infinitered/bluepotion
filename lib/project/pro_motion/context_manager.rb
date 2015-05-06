# RM-773
#module ProMotion
  class PMContextManager
    attr_reader :current_context

    class <<  self
      
      # TODO: this is not thread-safe - probably need to steal code from Singleton
      def instance(context=nil)
        @instance ||= new(context)
      end

      def current_context
        instance.current_context 
      end

    end

    private 

    def initialize(context)
      @current_context = context
    end
    # TODO: private_class_method not yet implemented
    # private_class_method :new

  end
#end

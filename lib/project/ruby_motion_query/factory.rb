  class RMQ
    # This is used internally, to get a new rmq instance, just call "rmq" in your view or controller or
    # just create a new one like so: RubyMotionQuery::RMQ.new
    #
    # @return [RMQ]
    def create_blank_rmq
      RMQ.create_with_array_and_selectors([], self.selectors, @originated_from)
    end

    # This is used internally, to get a new rmq instance, just call "rmq" in your view or controller or
    # just create a new one like so: RubyMotionQuery::RMQ.new
    #
    # @return [RMQ]
    def create_rmq_in_originated_from(*working_selectors)
      RMQ.create_with_selectors(working_selectors, @originated_from)
    end

    class << self

      # This is used internally, to get a new rmq instance, just call "rmq" in your view or controller or
      # just create a new one like so: RubyMotionQuery::RMQ.new
      #
      # @return [RMQ]
      def create_with_selectors(working_selectors, originated_from, working_parent_rmq = nil)
        q = RMQ.new
        q.originated_from = originated_from
        q.parent_rmq = working_parent_rmq
        q.selectors = working_selectors
        q
      end

      # This is used internally, to get a new rmq instance, just call "rmq" in your view or controller or
      # just create a new one like so: RubyMotionQuery::RMQ.new
      #
      # @return [RMQ]
      def create_with_array_and_selectors(array, working_selectors, originated_from, working_parent_rmq = nil) # TODO, convert to opts
        q = RMQ.new
        q.originated_from = originated_from
        q.selectors = working_selectors
        q.parent_rmq = working_parent_rmq
        q.selected = array # Must be last
        q
      end

    end
  end


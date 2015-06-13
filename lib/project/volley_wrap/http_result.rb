module VW
  class HTTPResult
    attr_accessor :object
    attr_accessor :error

    def initialize(response_object, error)
      @object = response_object
      @error = error
    end

    def success?
      !failure?
    end

    def failure?
      !!error
    end

  end
end


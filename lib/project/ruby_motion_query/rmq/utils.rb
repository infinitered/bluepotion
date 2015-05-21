class RMQ
  class << self

    def is_class?(o)
      o.class == Java::Lang::Class
    end

    def is_blank?(o)
      if o.is_a?(RMQ)
        RMQ.is_blank?(o.to_a)
      else
        o.respond_to?(:empty?) ? o.empty? : !o
      end
    end

    def weak_ref(o)
      o
    end

    def weak_ref_to_strong_ref(weak_ref)
      weak_ref
    end

    def is_object_weak_ref?(o)
      false
    end

    def weak_ref_value(o)
      o
    end

    def symbolize(s)
      s.to_s.gsub(/\s+/,"_").gsub(/\W+/,"").downcase.to_sym
    end
  end
end

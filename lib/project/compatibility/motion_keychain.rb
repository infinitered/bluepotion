class MotionKeychain
  class << self
    def key_store
      # TODO store this somewhere real
      @_key_store ||= {}
    end
    def get(key)
      key_store[key]
    end
    def set(key, value)
      key_store[key] = value
    end
  end
end

class RMQ
  # Do not use
  def selectors=(value)
    @selected_dirty = true
    normalize_selectors(value)
    @_selectors = value
  end

  def selectors
    @_selectors
  end

  def match(view, new_selectors)
    out = false

    # This method is written strange because the return in this example doesn't actually return (RM bug)
    # elsif selector == :tagged
    #    return true unless view.rmq_data.has_tag?

    new_selectors.each do |selector|
      if selector.is_a?(Java::Lang::Integer)
        if view.id == selector
          out = true
          break
        end
      elsif selector == :tagged
        if view.rmq_data.has_tag?
          out = true
          break
        end
      elsif selector.is_a?(Symbol)
        if (view.rmq_data.has_style?(selector)) || view.rmq_data.has_tag?(selector)
          out = true
          break
        end
      elsif selector.is_a?(Hash)
        if match_hash(view, selector)
          out = true
          break
        end
      elsif RMQ.is_class?(selector)
        if view.is_a?(selector)
          out = true
          break
        end
      else
        if view == selector
          out = true
          break
        end
      end
    end

    out
  end

  private

  def match_hash(view, hash)
    # TODO, check speed, and do sub hashes for stuff like origin
    # it's probably pretty slow
    hash.each do |k,v|
      return true if view.respond_to?(k) && (view.send(k) == v)
    end
    false
  end

  def normalize_selectors(a = self.selectors)
    a.flatten! if a
    a
  end
end

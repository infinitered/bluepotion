class RMQViewStyler
  attr_accessor :view
  attr_accessor :context
  attr_accessor :bg_color
  attr_accessor :corner_radius

  def initialize(view, context)
    @needs_finalize = false
    @view = view
    @context = context
    @bg_color = nil
    @corner_radius = nil
  end

  def cleanup
    @layout_params = nil
    @needs_finalize = nil
    @context = nil
    @bg_color = nil
    @corner_radius = nil
    @margin = nil
    @padding = nil
    @view = nil
  end

  def convert_dimension_value(value)
    case value
    when :match_parent, :full
      Android::View::ViewGroup::LayoutParams::MATCH_PARENT
    when :wrap_content
      Android::View::ViewGroup::LayoutParams::WRAP_CONTENT
    else
      dp2px(value)
    end
  end

  def layout_params
    @layout_params ||= begin
      #@view.setMargins(0, 0, 0, 0)
      #mp @view.LayoutParams
      if lp = @view.getLayoutParams
        lp
      else
        #mp 1
        #mp @view
        Android::View::ViewGroup::LayoutParams.new(0,0)
        #Android::Widget::LinearLayout::LayoutParams.new(0,0)
      end
    end
  end

  def layout=(value)
    return unless lp = layout_params

    if value == :full
      lp.width = convert_dimension_value(:full)
      lp.height = convert_dimension_value(:full)
      @view.setLayoutParams(lp)
    elsif value.is_a?(Hash)
      hash = value
      if w = (hash[:w] || hash[:width])
        lp.width = convert_dimension_value(w)
      end
      if h = (hash[:h] || hash[:height])
        lp.height = convert_dimension_value(h)
      end
      if l = (hash[:l] || hash[:left] || hash[:left_margin])
        lp.leftMargin = convert_dimension_value(l)
      end
      if t = (hash[:t] || hash[:top] || hash[:top_margin])
        lp.topMargin = convert_dimension_value(t)
      end
      if fr = (hash[:fr] || hash[:from_right] || hash[:right_margin])
        lp.rightMargin = convert_dimension_value(fr)
      end
      if fb = (hash[:fb] || hash[:from_bottom] || hash[:bottom_margin])
        lp.bottomMargin = convert_dimension_value(fb)
      end

      # TODO do center

      # TODO gravity

      # TODO do the relative bits

      @view.setLayoutParams(lp)

      if pad = hash[:padding]
        self.padding = pad
      end
    end

  end
  alias :frame= :layout=

  def padding=(pad)
    if pad.is_a?(Potion::Integer)
      pad = convert_dimension_value(pad)
      @view.setPadding(pad, pad, pad, pad)
    elsif pad.is_a?(Hash)
      @view.setPadding(
        convert_dimension_value(pad[:l] || pad[:left] || 0),
        convert_dimension_value(pad[:t] || pad[:top] || 0),
        convert_dimension_value(pad[:r] || pad[:right] || 0),
        convert_dimension_value(pad[:b] || pad[:bottom] || 0))
    else
      mp pad.class.name
    end
  end

  # use this if you need to do something after all style methods have been called (e.g.
  # applying layout params)
  def finalize
    return unless @needs_finalize

    create_rounded_bg if corner_radius
    layout_params.setMargins(margin[:left],
      margin[:top],
      margin[:right],
      margin[:bottom]) if layout_params.respond_to?(:setMargins)
    @view.setLayoutParams(layout_params)

    @view.setPadding(padding[:left], padding[:top], padding[:right], padding[:bottom])
  end


  def background_color=(color)
    @view.backgroundColor = @bg_color = convert_color(color)
  end

  def background_resource=(bg)
    @view.backgroundResource = bg
  end

  def layout_width=(layout_width)
    @needs_finalize = true
    layout_params.width = convert_dimension_value(layout_width)
  end

  def layout_height=(layout_height)
    @needs_finalize = true
    layout_params.height = convert_dimension_value(layout_height)
  end

  def gravity=(gravity)
    layout_params.gravity = convert_gravity(gravity)
  end

  def layout_center_in_parent=(center_in_parent)
    @needs_finalize = true
    center = center_in_parent ? Android::Widget::RelativeLayout::TRUE :
      Android::Widget::RelativeLayout::FALSE
    layout_params.addRule(Android::Widget::RelativeLayout::CENTER_IN_PARENT, center)
  end

  def layout_center_vertical=(center_vertical)
    @needs_finalize = true
    center = center_vertical ? Android::Widget::RelativeLayout::TRUE :
      Android::Widget::RelativeLayout::FALSE
    layout_params.addRule(Android::Widget::RelativeLayout::CENTER_VERTICAL, center)
  end

  def layout_center_horizontal=(center_horizontal)
    @needs_finalize = true
    center = center_horizontal ? Android::Widget::RelativeLayout::TRUE :
      Android::Widget::RelativeLayout::FALSE
    layout_params.addRule(Android::Widget::RelativeLayout::CENTER_HORIZONTAL, center)
  end

  def layout_align_parent_left=(left_in_parent)
    @needs_finalize = true
    left = left_in_parent ? Android::Widget::RelativeLayout::TRUE :
      Android::Widget::RelativeLayout::FALSE
    layout_params.addRule(Android::Widget::RelativeLayout::ALIGN_PARENT_LEFT, left)
  end

  def layout_align_parent_right=(right_in_parent)
    @needs_finalize = true
    right = right_in_parent ? Android::Widget::RelativeLayout::TRUE :
      Android::Widget::RelativeLayout::FALSE
    layout_params.addRule(Android::Widget::RelativeLayout::ALIGN_PARENT_RIGHT, right)
  end

  def padding_left=(pad_left)
    @needs_finalize = true
    padding[:left] = dp2px(pad_left)
  end

  def padding_top=(pad_top)
    @needs_finalize = true
    padding[:top] = dp2px(pad_top)
  end

  def padding_right=(pad_right)
    @needs_finalize = true
    padding[:right] = dp2px(pad_right)
  end

  def padding_bottom=(pad_bottom)
    @needs_finalize = true
    padding[:bottom] = dp2px(pad_bottom)
  end

  def margin_left=(m_left)
    @needs_finalize = true
    margin[:left] = dp2px(m_left)
  end

  def margin_top=(m_top)
    @needs_finalize = true
    margin[:top] = dp2px(m_top)
  end

  def margin_right=(m_right)
    @needs_finalize = true
    margin[:right] = dp2px(m_right)
  end

  def margin_bottom=(m_bottom)
    @needs_finalize = true
    margin[:bottom] = dp2px(m_bottom)
  end

  def margin=(m)
    @needs_finalize = true
    margin[:left] = margin[:top] = margin[:right] = margin[:bottom] = dp2px(m)
  end

  # This can only be used on a widget that's within a LinearLayout
  def layout_weight=(weight)
    @needs_finalize = true
    layout_params.weight = weight
  end

  def layout_gravity=(gravity)
    @needs_finalize = true
    layout_params.gravity = convert_gravity(gravity)
  end

  def corner_radius(corner_radius)
    @needs_finalize = true
    @corner_radius = dp2px(corner_radius)
  end

  def convert_color(color)
    return ColorFactory.from_hex(color) if color.is_a?(String)
    color
  end

  def convert_gravity(gravity)
    case gravity
    when :center then Android::View::Gravity::CENTER
    when :left then Android::View::Gravity::LEFT
    else
      gravity
    end
  end

  def dp2px(dp_val)
    (dp_val * density + 0.5).to_i
  end

  def density
    @density ||= @context.getResources.getDisplayMetrics.density
  end

  def create_drawable(corner_radius)
    createDrawable(corner_radius)
  end

  def visibility=(value)
    case value
    when :visible, true
      view.setVisibility(Potion::View::VISIBLE)
    when :invisible, false
      view.setVisibility(Potion::View::INVISIBLE)
    when :gone
      view.setVisibility(Potion::View::GONE)
    end
  end
  alias :visible= :visibility=

  private

  def padding
    @padding ||= { left: 0, top: 0, right: 0, bottom: 0 }
  end

  def margin
    @margin ||= { left: 0, top: 0, right: 0, bottom: 0 }
  end

  def convert_dimension_value(value)
    case value
    when :match_parent, :full
      Android::View::ViewGroup::LayoutParams::MATCH_PARENT
    when :wrap_content
      Android::View::ViewGroup::LayoutParams::WRAP_CONTENT
    else
      dp2px(value)
    end
  end

  def create_rounded_bg
    # creating this shape in Ruby raises an ART error, but it works in Java
    #radii = [corner_radius, corner_radius, corner_radius, corner_radius,
    #         corner_radius, corner_radius, corner_radius, corner_radius]
    #shape = Android::Graphics::Drawable::Shapes::RoundRectShape.new(radii, nil, nil)

    # StyleHelper contains a Java extension
    shape = StylerHelper.shared.createRoundRect(dp2px(corner_radius))

    drawable = Android::Graphics::Drawable::ShapeDrawable.new(shape)
    drawable.paint.color = bg_color
    @view.setBackgroundDrawable(drawable)
  end

end

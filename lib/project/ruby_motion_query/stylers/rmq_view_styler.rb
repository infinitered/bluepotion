class RMQViewStyler
  attr_accessor :view
  attr_accessor :context
  attr_accessor :bg_color
  attr_accessor :corner_radius

  def initialize(view, context)
    @view = view
    @context = context
    @bg_color = nil
    @corner_radius = nil
  end

  def background_color=(color)
    view.backgroundColor = @bg_color = convert_color(color)
  end
  alias_method :backgroundColor=, :background_color=

  def background_resource=(bg)
    view.backgroundResource = bg
  end

  def layout_width=(layout_width)
    layout_params.width = convert_dimension_value(layout_width)
  end

  def layout_height=(layout_height)
    layout_params.height = convert_dimension_value(layout_height)
  end

  def gravity=(gravity)
    layout_params.gravity = convert_gravity(gravity)
  end

  def layout_center_in_parent=(center_in_parent)
    center = center_in_parent ? Android::Widget::RelativeLayout::TRUE :
      Android::Widget::RelativeLayout::FALSE
    layout_params.addRule(Android::Widget::RelativeLayout::CENTER_IN_PARENT, center)
  end
  alias_method :layout_centerInParent=, :layout_center_in_parent=

  def layout_center_vertical=(center_vertical)
    center = center_vertical ? Android::Widget::RelativeLayout::TRUE :
      Android::Widget::RelativeLayout::FALSE
    layout_params.addRule(Android::Widget::RelativeLayout::CENTER_VERTICAL, center)
  end
  alias_method :layout_centerVertical=, :layout_center_in_parent=

  def layout_align_parent_left=(left_in_parent)
    left = left_in_parent ? Android::Widget::RelativeLayout::TRUE :
      Android::Widget::RelativeLayout::FALSE
    layout_params.addRule(Android::Widget::RelativeLayout::ALIGN_PARENT_LEFT, left)
  end
  alias_method :layout_alignParentLeft=, :layout_align_parent_left=

  def layout_align_parent_right=(right_in_parent)
    right = right_in_parent ? Android::Widget::RelativeLayout::TRUE :
      Android::Widget::RelativeLayout::FALSE
    layout_params.addRule(Android::Widget::RelativeLayout::ALIGN_PARENT_RIGHT, right)
  end
  alias_method :layout_alignParentRight=, :layout_align_parent_right=

  def padding_left=(pad_left)
    padding[:left] = dp2px(pad_left)
  end
  alias_method :paddingLeft=, :padding_left=

  def padding_top=(pad_top)
    padding[:top] = dp2px(pad_top)
  end
  alias_method :paddingTop=, :padding_top=

  def padding_right=(pad_right)
    padding[:right] = dp2px(pad_right)
  end
  alias_method :paddingRight=, :padding_right=

  def padding_bottom=(pad_bottom)
    padding[:bottom] = dp2px(pad_bottom)
  end
  alias_method :paddingBottom=, :padding_bottom=

  def padding=(pad)
    padding[:left] = padding[:top] = padding[:right] = padding[:bottom] = dp2px(pad)
  end

  def margin_left=(m_left)
    margin[:left] = dp2px(m_left)
  end
  alias_method :marginLeft=, :margin_left=

  def margin_top=(m_top)
    margin[:top] = dp2px(m_top)
  end
  alias_method :marginTop=, :margin_top=

  def margin_right=(m_right)
    margin[:right] = dp2px(m_right)
  end
  alias_method :marginRight=, :margin_right=

  def margin_bottom=(m_bottom)
    margin[:bottom] = dp2px(m_bottom)
  end
  alias_method :marginBottom=, :margin_bottom=

  def margin=(m)
    margin[:left] = margin[:top] = margin[:right] = margin[:bottom] = dp2px(m)
  end

  # this can only be used on a widget that's within a LinearLayout
  def layout_weight=(weight)
    layout_params.weight = weight
  end

  def layout_gravity=(gravity)
    layout_params.gravity = convert_gravity(gravity)
  end

  def corner_radius(corner_radius)
    @corner_radius = dp2px(corner_radius)
  end

  # use this if you need to do something after all style methods have been called (e.g.
  # applying layout params)
  def finalize
    create_rounded_bg if corner_radius
    view.setPadding(padding[:left], padding[:top], padding[:right], padding[:bottom])
    layout_params.setMargins(margin[:left],
      margin[:top],
      margin[:right],
      margin[:bottom]) if layout_params.respond_to?(:setMargins)
    view.setLayoutParams(layout_params)
  end

  def layout_params
    @layout_params ||= view.getLayoutParams()
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
    @density ||= context.getResources.getDisplayMetrics.density
  end

  def create_drawable(corner_radius)
    createDrawable(corner_radius)
  end

  private

  def padding
    @padding ||= { left: 0, top: 0, right: 0, bottom: 0 }
  end

  def margin
    @margin ||= { left: 0, top: 0, right: 0, bottom: 0 }
  end

  def convert_dimension_value(value)
    case value
    when :match_parent
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
    view.setBackgroundDrawable(drawable)
  end

end

class RMQ
    # these only work if widget is in a RelativeLayout
    #
    def align_to_left_of(other)
      set_alignment_to(other, Android::Widget::RelativeLayout::LEFT_OF)
    end

    def align_to_right_of(other)
      set_alignment_to(other, Android::Widget::RelativeLayout::RIGHT_OF)
    end

    def align_below(other)
      set_alignment_to(other, Android::Widget::RelativeLayout::BELOW)
    end

    private

    def set_alignment_to(other, rule)
      params = @view.layoutParams
      params.addRule(rule, other.get.id)
      @view.setLayoutParams(params)
    end


    def apply_style_to_view(view, style_name)
      styler = styler_for(view)
      stylesheet.send(style_name, styler)
      styler.finalize
    end

    def styler_for(view)
      case view
      when Android::Widget::RelativeLayout  then StylersRelativeLayoutStyler.new(view, context)
      when Android::Widget::LinearLayout    then StylersLinearLayoutStyler.new(view, context)
      when Android::Widget::TextView        then StylersTextViewStyler.new(view, context)
      when Android::Widget::ImageView       then StylersImageViewStyler.new(view, context)
      when Android::Widget::ImageButton     then StylersImageButtonStyler.new(view, context)
      when Android::Widget::Button          then StylersButtonStyler.new(view, context)
      else
        StylersViewStyler.new(view, context)
      end
    end
end

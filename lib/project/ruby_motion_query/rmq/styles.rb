class RMQ

  def stylesheet=(value)
    controller = self.screen || self.activity
    unless value.is_a?(RMQStylesheet)
      value = value.new(controller)
    end
    @_stylesheet = value
    controller.rmq_data.stylesheet = value
    self
  end

  def stylesheet
    @_stylesheet ||= begin
      if self.controller && (ss = self.controller.rmq_data.stylesheet)
        ss
      elsif (prmq = self.parent_rmq) && prmq.stylesheet
        prmq.stylesheet
      end
    end
  end

  def styler_for(view)
    context = RMQApp.context
    styler = case view
      when Android::Widget::RelativeLayout  then StylersRelativeLayoutStyler.new(view, context)
      when Android::Widget::LinearLayout    then StylersLinearLayoutStyler.new(view, context)
      when Android::Widget::TextView        then StylersTextViewStyler.new(view, context)
      when Android::Widget::ImageView       then StylersImageViewStyler.new(view, context)
      when Android::Widget::ImageButton     then StylersImageButtonStyler.new(view, context)
      when Android::Widget::Button          then StylersButtonStyler.new(view, context)
    else
      StylersViewStyler.new(view, context)
    end
    styler
  end

  def apply_style(*style_names)
    if style_names
      selected.each do |selected_view|
        style_names.each do |style_name|
          apply_style_to_view selected_view, style_name
        end
      end
    end
    self
  end
  alias :apply_styles :apply_style

  def apply_style_to_view(view, style_name)
    styler = styler_for(view)
    self.stylesheet.send(style_name, styler)
    styler.finalize
  end

  # these only work if widget is in a RelativeLayout
  #
  #def align_to_left_of(other)
    #set_alignment_to(other, Android::Widget::RelativeLayout::LEFT_OF)
  #end

  #def align_to_right_of(other)
    #set_alignment_to(other, Android::Widget::RelativeLayout::RIGHT_OF)
  #end

  #def align_below(other)
    #set_alignment_to(other, Android::Widget::RelativeLayout::BELOW)
  #end

  #private

  #def set_alignment_to(other, rule)
    #params = @view.layoutParams
    #params.addRule(rule, other.get.id)
    #@view.setLayoutParams(params)
  #end
end

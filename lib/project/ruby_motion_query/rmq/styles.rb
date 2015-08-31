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
    styler = RMQ.styler_pool[view.class] || RMQ.styler_pool[:view_styler]
    styler.reset(view)
    styler
  end

  def apply_style(*style_names)

    if style_names
      if style_names.length == 1 && selected.length == 1
        apply_style_to_view selected.first, style_names.first
      else
        selected.each do |selected_view|
          style_names.each do |style_name|
            apply_style_to_view selected_view, style_name
          end
        end
      end

      # TODO, remove this hack once RMA is fixed
      #tproc = proc do |style_name|
        #apply_style_to_view @apply_style_selected_view, style_name
      #end
      #selected.each do |selected_view|
        #@apply_style_selected_view = selected_view
        #style_names.each &tproc
      #end
    end
    self
  end
  alias :apply_styles :apply_style

  def apply_style_to_view(view, style_name)

    #begin
      if sheet = self.stylesheet # 0.18 +0.02
        styler = self.styler_for(view) # 0.34 +0.16 -0.10
        sheet.send(style_name, styler) # 0.37 +0.03
        styler.finalize # +0.04
        #styler.cleanup # +0.02

        view.rmq_data.add_to_styles(style_name)
        view.rmq_style_applied # +0.03
        #return if $return
      end
    #rescue NoMethodError => e
      #if e.message =~ /.*#{style_name.to_s}.*/
        #$stderr.puts "\n[RMQ ERROR]  style_name :#{style_name} doesn't exist for a #{view.class.name}. Add 'def #{style_name}(st)' to #{stylesheet.class.name} class\n\n"
      #else
        #raise e
      #end
    #end
  end

  def style
    selected.each do |view|
      yield(styler_for(view))
    end
    self
  end

  def styles
    out = selected.map do |view|
      view.rmq_data.styles
    end
    out.flatten!.uniq
  end

  def reapply_styles
    selected.each do |selected_view|
      selected_view.rmq_data.styles.each do |style_name|
        apply_style_to_view selected_view, style_name
      end
    end
    self
  end

  class << self
    attr_reader :styler_pool

    def create_styler_pool
      return @styler_pool if @styler_pool

      context = RMQ.app.context
      @styler_pool = {
        Android::Widget::RelativeLayout => RMQRelativeLayoutStyler.new(nil, context),
        Android::Widget::LinearLayout => RMQLinearLayoutStyler.new(nil, context),
        Android::Widget::TextView => RMQTextViewStyler.new(nil, context),
        Android::Widget::ImageView => RMQImageViewStyler.new(nil, context),
        Android::Widget::ImageButton => RMQImageButtonStyler.new(nil, context),
        Android::Widget::Button => RMQButtonStyler.new(nil, context),
        view_styler: RMQViewStyler.new(nil, context)
      }
    end
  end

end


__END__

#  # these only work if widget is in a RelativeLayout
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

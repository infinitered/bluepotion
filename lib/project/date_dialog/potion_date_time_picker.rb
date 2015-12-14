class PotionDateTimePicker

  def self.show(opts={}, &block)
    picker = PotionDateTimePicker.new(opts, &block)
  end

  def initialize(opts={}, &block)
    @date = opts.fetch(:date, Time.new)
    @is_date = opts.fetch(:type, :date) == :date
    @hour_of_day = opts.fetch(:hour, 0)
    @minute = opts.fetch(:minute, 0)
    @is_24_hour = opts.fetch(:is_24_hour, true)

    @completion = block
    setup
  end

  def setup
    if @is_date
      year = @date.strftime('%Y').to_i # TODO bug RM or BP ?
      month = @date.month
      day = @date.date

      @dialog = Android::App::DatePickerDialog.new(find.activity,
                                                   RMQDateListener.new(&@completion),
                                                   year, month, day)
    else
      @dialog = Android::App::TimePickerDialog.new(find.activity,
                                                   RMQTimeListener.new(&@completion),
                                                   @hour_of_day, @minute, @is_24_hour)
    end
    @dialog.show
    @dialog
  end

end
class Time
  def self.iso8601(iso8601_string)
    timestring = iso8601_string.toString
    timestring = timestring.replaceAll("Z", "+00:00")
    timestring = timestring.substring(0, 22) + timestring.substring(23)
    sdf = Java::Text::SimpleDateFormat.new("yyyy-MM-dd'T'HH:mm:ss+SSS")
    sdf.setTimeZone(Java::Util::TimeZone.getTimeZone("UTC"))
    date = sdf.parse(timestring)
    Time.new(date.getTime())
  end

  def self.milliseconds_since_epoch
    Java::Lang::System.currentTimeMillis.doubleValue
  end

  def today?
    today = Time.now
    (self.year == today.year) && (self.month == today.month) && (self.date == today.date)
  end

  def strftime(str)
    converter = {
      #Ruby => Android
      '%A'  =>  'EEEE',
      '%b'  =>  'MMM',
      '%B'  =>  'MMMM',
      '%-e' =>  'd',
      '%-l' =>  'h',
      '%I' =>   'h',
      '%P'  =>  'a',
      '%M'  =>  'mm',
      '%p'  =>  'a',
      '%m'  =>  'MM',
      '%d'  =>  'dd',
      '%Y'  =>  'yyyy',
      '%Z'  =>  'z'
    }

    # TODO: RM 4.0 Workaround
    rm4 = [str.toString]
    converter.each do |k, v|
      rm4 << rm4.last.replaceAll(k, v)
    end
    converted = rm4.last
    rm4.clear
    # -- can't wait to nuke that code

    # What it used to be:
    # converted = str.toString
    # converter.each do |k,v|
    #   converted = converted.replaceAll(k, v)
    # end

    formatter = Java::Text::SimpleDateFormat.new(converted)
    formatter.format(self).to_s
  end
end

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

  def self.from_string(str, format='%Y-%m-%d')
    converted = self.convert(format)
    formatter = Java::Text::SimpleDateFormat.new(converted)
    formatter.parse(str)
  end

  def strftime(str)
    converted = self.convert(str)
    formatter = Java::Text::SimpleDateFormat.new(converted)
    formatter.format(self).to_s
  end

  private
  def self.convert(str)
    converter = {
        #Ruby => Android
        '%A'  =>  'EEEE',
        '%b'  =>  'MMM',
        '%-e' =>  'd',
        '%-l' =>  'h',
        '%P'  =>  'a',
        '%M'  =>  'mm',
        '%P'  =>  'a',
        '%m'  =>  'MM',
        '%d'  =>  'dd',
        '%Y'  =>  'yyyy'
    }

    converted = str.toString
    converter.each do |k,v|
      converted = converted.replaceAll(k, v)
    end
    converted
  end
end

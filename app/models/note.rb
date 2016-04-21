class Note < ActiveRecord::Base
  WEEK_DAYS = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN']

  def self.create_multiple_from(file)

    notams = Parser.new(file).parse

    notams.map do |notam_arr|
      new_note = Note.new
      new_note.parse_and_assign_days(notam_arr)
      new_note.save
    end.all?
  end

  def get_icao_code(notam_array)
    self.icao_code = notam_array[0]
  end

  def parse_and_assign_days(notam_array)

    get_icao_code(notam_array)
    daytime_arr = notam_array[1]

    daytime_arr.each do |item|
      if item.include?('CLOSED') || item.include?('CLSD') #if item is of the type 'SUN CLOSED' or 'SUN CLSD'
        write_day_notam item[0..2].downcase, item[4..-1]
      elsif item.split(' ').size > 2 #if item is of the type 'SAT 0630-0730 1900-2100'
        write_day_notam item[0..2].downcase, item[4..-1]
      elsif item.split(' ')[0].split('-')[0] =~ /\d/ #if item is of the type 'SAT0630-0730 1900-2100'
        write_day_notam item[0..2].downcase, item[3..-1]
      else #if item is of the type 'THU 0500-2130' or 'MON-WED 0500-1830'
        str = item.split(' ')
        day_range = str[0]
        time_range = str[1]

        day = day_range.split('-')

        if day.size > 1 # we have a range like 'MON-WED'
          left = WEEK_DAYS.index(day[0])
          right = WEEK_DAYS.index(day[1])
          left.upto(right) do |day|
            write_day_notam WEEK_DAYS[day].downcase, time_range
          end
        else # we have a day like 'MON'
          write_day_notam day_range.downcase, time_range
        end
      end
    end

  end

  def write_day_notam(attribute_name, value)
    send("#{attribute_name}=", value) if respond_to?("#{attribute_name}=")
  end
end

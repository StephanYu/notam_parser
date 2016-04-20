class Note < ActiveRecord::Base
  WEEK_DAYS = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN']

  def self.create_multiple_from(file)
    binding.pry
    notams = Parser.new(file).parse
    # notams =
    #  [["ESGJ", ["SAT 0630-0730 1900-2100", "MON-WED 0500-1830", "THU 0500-2130", "FRI 0730-2100", "SUN CLOSED"]],
    #  ["ESGJ", ["SAT0630-0730 1900-2100", "TUE-THU 0500-2100", "MON 0500-2000", "FRI 0545-2100", "SUN 1215-2000"]],
    #  ["ESNN", ["WED-THU 0500-2300", "MON 0445-2115", "TUE 0500-2130", "FRI 0500-2115", "SAT 0715-1300", "SUN 1115-2145"]],
    #  ["ESNN", ["WED-THU 0500-2300", "MON 0500-2215", "TUE 0500-2130", "FRI 0500-2015", "SAT 1100-1300", "SUN 1115-2300"]],
    #  ["ESNN", ["WED-THU 0500-2300", "MON 0500-2215", "TUE 0500-2130", "FRI 0500-1830", "SAT 1100-1300", "SUN 1115-2145"]],
    #  ["ESNO", ["MON-WED 0430-2130", "THU 0430-2215", "FRI 0445-2130", "SUN 1030-1900", "SAT CLSD"]],
    #  ["ESNO", ["TUE-WED 0530-2230", "MON 0530-2030", "THU 0530-2315", "FRI 0545-2230", "SUN 1130-2000", "SAT CLSD"]],
    #  ["ESNZ", ["MON-TUE 0515-2145", "WED-THU 0515-2255", "FRI 0515-2145", "SAT 0645-1845", "SUN 0645-2145"]],
    #  ["ESSV", ["MON-THU 0530-2115", "FRI 0530-2000", "SAT 0730-1600", "SUN 1000-2115"]],
    #  ["ESSV", ["MON-THU 0530-2115", "FRI 0530-2000", "SAT 0730-1830", "SUN 0730-2115"]]]
    notams.map do |notam_arr|
      new_note = Note.new
      new_note.parse_and_assign_days(notam_arr)
      new_note.save
    end.all?
  end

  def parse_and_assign_days(notam_array)
    # ["ESGJ", ["SAT 0630-0730 1900-2100", "MON-WED 0500-1830", "THU 0500-2130", "FRI 0730-2100", "SUN CLOSED"]]
    daytime_arr = notam_array[1]
    icao_code   = notam_array[0]

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

    self.icao_code = icao_code
  end

  def write_day_notam(attribute_name, value)
    send("#{attribute_name}=", value) if respond_to?("#{attribute_name}=")
  end
end

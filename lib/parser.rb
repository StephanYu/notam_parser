class Parser
  FLTR_STR  = "AERODROME HOURS OF OPS/SERVICE"
  FLTR2_STR = "CREATED:"

  def initialize(file)
    @file = file
  end

  def parse
    arr = []

    # filter all Notams by string "AERODROME HOURS OF OPS/SERVICE"
    note_from_file.map do |note|
      arr << note if note.include?(FLTR_STR)
    end

    # parse each note and separate ICAO Code and string with weekdays and opening times and create subarrays for each note.
    notam_arr = []
    sub_arr   = []

    arr.map do |item|
      sub_arr << item.match(/[A]\) \w{4}/)[0][-4..-1]
      sub_arr << item.split(FLTR_STR)[1].split(FLTR2_STR)[0].gsub(/(:|\.|,)/, "").strip
      notam_arr << sub_arr
      sub_arr = []
    end

    # parse string at index 1 from sub arrays in notam_arr and extract weekdays and corresponding times
    day_time_arr = []

    notam_arr.each do |item|
      string = item[1]
      regexp_arr = [/\w{3}\s\d{4}-\d{4}\s\d{4}-\d{4}/, /\w{3}\d{4}-\d{4}\s\d{4}-\d{4}/, /\w{3}-\w{3}\s\d{4}-\d{4}/, /\w{3}\s\d{4}-\d{4}/, /\w{3}\s\w{6}/, /\w{3}\s\w{4}/]
      regexp_arr.each do |pattern|
        while string =~ pattern do
          day_time_arr << string.slice!(pattern)
        end
      end
      day_time_arr.delete_if {|item| item =~ /\A\d{3}\s\d{4}-\d{4}/ }
      item[1] = day_time_arr.compact
      day_time_arr = []
    end

    notam_arr
  end

  private

  # split text file into separate notes
  def note_from_file
    @note_from_file ||= @file.read.gsub("\n", " ").split(/\s{2,}/)
  end
end

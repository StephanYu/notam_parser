require 'parser'

describe Parser do
  describe '#filter_notams_by' do
    let(:correct_notam) {
      'B0519/15 NOTAMN
      Q) ESAA/QFAAH/IV/NBO/A /000/999/5746N01404E005
      A) ESGJ B) 1502271138 C) 1503012359
      E) AERODROME HOURS OF OPS/SERVICE MON-WED 0500-1830 THU 0500-2130
      FRI
      0730-2100 SAT 0630-0730, 1900-2100 SUN CLOSED
      CREATED: 27 Feb 2015 11:40:00
      SOURCE: EUECYIYN'
    }
    let(:incorrect_notam) {
      'B0517/15 NOTAMN
      Q) ESAA/QSTAH/IV/BO /A /000/999/5746N01404E005
      A) ESGJ B) 1502271133 C) 1503012359
      E) AERODROME CONTROL TOWER (TWR) HOURS OF OPS/SERVICE MON-THU
      0000-0100, 0500-2359 FRI 0000-0100, 0730-2100 SAT 0630-0730,
      1900-2100 SUN 2200-2359
      CREATED: 27 Feb 2015 11:35:00
      SOURCE: EUECYIYN'
    }

    let(:string) { 'AERODROME HOURS OF OPS/SERVICE' }
    it 'filters all notams by :string' do
      parser = Parser.new(@note_from_file)
      expect(parser.filter_notams_by(:string).count).to eq 1
      #create a text file with two notams (one including string and one without)
      #call #
      #expect(notam_arr.count).to eq 1
    end
  end

  describe '#parse' do
    let(:string) { 'AERODROME HOURS OF OPS/SERVICE' }
    let(:notams) { ['AERODROME HOURS OF OPS/SERVICE', 'something else'] }

    it 'filters the notam array by :string' do

    #     filter_notams_by(:string)
    #     #create a text file with two notams (one including string and one without)
    #     #call #
    #     #expect(notam_arr.count).to eq 1
    end


    it 'parse each note and separate ICAO Code and string with weekdays and opening times and create subarrays for each note.'
    it 'parse string at index 1 from sub arrays in notam_arr and extract weekdays and corresponding times'
    #outcome should be # [["ESGJ", ["SAT 0630-0730 1900-2100", "MON-WED 0500-1830", "THU 0500-2130", "FRI 0730-2100", "SUN CLOSED"]],
    #  ["ESGJ", ["SAT0630-0730 1900-2100", "TUE-THU 0500-2100", "MON 0500-2000", "FRI 0545-2100", "SUN 1215-2000"]]]
  end

  describe '#note_from_file' do
    context 'the file has proper spacing of at least two whitespaces' do
      let(:file) { '123\n asd' }

      it 'returns the correct parsed content' do
        #call note_from_file
        expect(subject.note_from_file).to eq ['123', 'asd']
      end
    end

    context 'the file has improper spacing of less than two whitespaces' do
      let(:file) { '123\nasd' }

      it 'returns the incorrect parsed content' do
        expect(subject.note_from_file).to eq ['123asd']
      end
    end
  end

end

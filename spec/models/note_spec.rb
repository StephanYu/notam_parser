require 'rails_helper'

describe Note do
  describe '#create_multiple_from' do
    before do
      @file = File.open("valid_only.txt")
    end

    after do
      @file.close
    end

    context 'successful in creating multiples' do
      it 'saves new notes to the db' do
        Note.create_multiple_from(@file)
        expect(Note.all.size).to eq 2
      end

      it 'returns true when all array elements are parsed correctly' do
        #The method all? returns true if the block never returns false or nil
        expect(Note.create_multiple_from(@file)).to be_truthy
      end

      it 'saves the correct dates' do
        Note.create_multiple_from(@file)
        expect(Note.first.sun).to eq('CLOSED')
      end
    end

    context 'unsuccessful in creating multiples' do
      before do
        @file = File.open("invalid.txt")
      end

      xit 'does not save notes to the db' do
        Note.create_multiple_from(@file)
        expect(Note.all.size).to eq 0
      end

      xit 'returns false' do
        expect(Note.create_multiple_from(@file)).to be_falsey
      end
    end
  end

  describe '#get_icao_code' do
    let(:note) { Note.new }
    let(:notam_array) { ["ESGJ", ["SAT 0630-0730 1900-2100", "MON-WED 0500-1830", "THU 0500-2130", "FRI 0730-2100", "SUN CLOSED"]] }

    it 'extracts the ICAO code from the array' do
      expect(note.get_icao_code(notam_array)).to eq "ESGJ"
    end
  end

  describe '#parse_and_assign_days' do
    let(:notam_array) do
      ["ESGJ", ["SAT 0630-0730 1900-2100", "MON-WED 0500-1830", "THU 0500-2130", "FRI 0730-2100", "SUN CLOSED"]]
    end
    let(:note) { Note.new }

    context 'correctly parses date ranges of varying formats' do
    # test different date formats
      # if item is of the type 'SUN CLOSED' or 'SUN CLSD'
      it 'sets the attributes value to CLOSED or CLSD'
      # if item is of the type 'SAT 0630-0730 1900-2100'
      it 'sets the attributes value to 0630-0730 1900-2100'
      # if item is of the type 'SAT0630-0730 1900-2100'
      it 'sets the attributes value to 0630-0730 1900-2100'
      # if item is of the type 'THU 0500-2130' or 'MON-WED 0500-1830'
      it 'sets the attributes value to 0500-2130'
          # we have a range like 'MON-WED'
          it 'sets the attribute to MON-WED'
          # we have a day like 'MON'
          it 'sets the attribute to MON'
    end
  end

  describe '#write_day_notam' do
    it 'sets the value if attribute name exists' #use MON
    it 'does not set the value if attribute name is missing' #use NOT
  end
end

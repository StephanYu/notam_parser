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
        expect(Note.create_multiple_from(@file)).to be_truthy #TO-DO: read diff true vs truthy
      end

      it 'saves the correct dates' do
        expect(Note.first.fri).to eq('somehitnh')
      end
    end

    context 'unsuccessful in creating multiples' do
      # work with invalid.txt
      it 'does not save notes to the db'
      it 'returns false'
    end
  end

  describe '#parse_and_assign_days' do
    let(:notam_array) do
      ["ESGJ", ["SAT 0630-0730 1900-2100", "MON-WED 0500-1830", "THU 0500-2130", "FRI 0730-2100", "SUN CLOSED"]]
    end
    let(:note) { Note.new }

    # move to separate test
    it 'extracts the ICAO code' do
      expect(note.parse_and_assign_days(notam_array)).to eq('ESGJ')
    end

    context 'correctly parses date ranges of varying formats' do
      # test different date formats
    end
  end

  describe '#write_day_notam' do
    it 'sets the value if attribute name exists' #use MON
    it 'does not set the value if attribute name is missing' #use NOT
  end
end

require 'rails_helper'

describe Note do
  describe '#create_multiple_from' do
    context 'successful in creating multiples' do
      it 'saves new notes to the db' do
        #create notam array with two elements and count size
        #count Note.all.size
        #create_multiple_from
        #expect(Note.all.size).to eq 2
      end

      it 'returns true when all array elements are parsed correctly and saved to db' do
        #The method all? returns true if the block never returns false or nil
      end
    end

    context 'unsuccessful in creating multiples' do
      it 'does not save notes to the db'
      it 'returns false'
    end
  end

  describe '#parse_and_assign_days' do
    it 'extracts the ICAO code'
    it 'correctly parses date ranges of varying formats'
  end

  describe '#write_day_notam' do
    it 'sets the value if attribute name exists' #use MON
    it 'does not set the value if attribute name is missing' #use NOT
  end
end

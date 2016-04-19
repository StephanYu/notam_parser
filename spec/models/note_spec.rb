require 'spec_helper'

describe Note do
  describe '#create_multiple_from' do
    context 'the notam array has the correctly formatted elements'
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

  describe '#parse_and_assign_days' do

  end

  describe '#write_day_notam' do

  end
end

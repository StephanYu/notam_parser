require 'parser'
require 'pry-byebug'
require 'rails_helper'
# require_relative './support/valid_only.txt'
describe Parser do

  describe '#parse' do
    context 'only valid notams' do
      let(:notam_array) do
        [["ESGJ", ["SAT 0630-0730 1900-2100", "MON-WED 0500-1830", "THU 0500-2130", "FRI 0730-2100", "SUN CLOSED"]], ["ESGJ", ["SAT 0630-0730 1900-2100", "MON-WED 0500-1830", "THU 0500-2130", "FRI 0730-2100", "SUN CLOSED"]]]
      end
      before do
        @file = File.open("valid_only.txt")
        @notams = Parser.new(@file).parse
      end

      after do
        @file.close
      end

      it 'returns an array of subarrays' do
        expect(@notams).to eq notam_array
      end

      it 'contains the same number of elements' do
        expect(@notams.count).to be 2
      end
    end

    context 'valid and invalid notams' do
      it 'contains the same number of elements as valid notams'
    end
  end

end

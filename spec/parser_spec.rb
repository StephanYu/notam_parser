require 'parser'

describe Parser do
  describe '#initialize' do
    let(:test_file) { 'test file' }

    it 'sets the @file variable' do
      @file = subject.new(:test_file)
      expect(@file).to eq :test_file
    end
  end

  describe '#parse' do
    it 'filters all notams by string "AERODROME HOURS OF OPS/SERVICE"' do

    end
    it 'parse each note and separate ICAO Code and string with weekdays and opening times and create subarrays for each note.'
    it 'parse string at index 1 from sub arrays in notam_arr and extract weekdays and corresponding times'
  end

  describe '#note_from_file' do
    context 'the file has proper spacing of at least two whitespaces' do
      let(:file) { '123\n asd' }

      it 'returns the correct parsed content' do
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

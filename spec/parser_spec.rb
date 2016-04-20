require 'parser'

describe Parser do

  describe '#parse' do
    it 'returns an array of subarrays' do
      file = File.read("notam_data.txt")
      notams = Parser.new(file).parse
      expect(notams.count).to be []
      #outcome should be # [["ESGJ", ["SAT 0630-0730 1900-2100", "MON-WED 0500-1830", "THU 0500-2130", "FRI 0730-2100", "SUN CLOSED"]],
      #  ["ESGJ", ["SAT0630-0730 1900-2100", "TUE-THU 0500-2100", "MON 0500-2000", "FRI 0545-2100", "SUN 1215-2000"]]]
    end
    context 'only valid notams' do
      it 'contains the same number of elements as notams'
    end
    context 'valid and invalid notams' do
      it 'contains the same number of elements as valid notams'
    end
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

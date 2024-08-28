require 'rspec'
require_relative '../../src/searching/binary'

describe '#binary_search' do
  context 'when the haystack is of odd length' do
    let(:haystack) { [1, 3, 5, 7, 9] }

    it 'returns the index of the needle when it\'s the first guess' do
      expect(binary_search(5, haystack)).to eq 2
    end

    it 'returns the index of the needle even if it\'s at the start or end of the array' do
      expect(binary_search(1, haystack)).to eq 0
      expect(binary_search(9, haystack)).to eq 4
    end

    it 'returns the index of the needle when it\'s in the middle-ish' do
      expect(binary_search(3, haystack)).to eq 1
      expect(binary_search(7, haystack)).to eq 3
    end

    it 'returns nil when the needle is not in the haystack' do
      expect(binary_search(2, haystack)).to be_nil
    end

    it 'returns nil when the needle is off either end of the haystack' do
      expect(binary_search(-1, haystack)).to be_nil
      expect(binary_search(100, haystack)).to be_nil
    end
  end

  context 'when the haystack has an even number of elements' do
    let(:haystack) { [1, 2, 3, 4] }

    it 'returns the index of the needle when it\'s the first guess' do
      expect(binary_search(2, haystack)).to eq 1
    end

    it 'returns the index of the needle even if it\'s at the start or end of the array' do
      expect(binary_search(1, haystack)).to eq 0
      expect(binary_search(4, haystack)).to eq 3
    end

    it 'returns the index of the needle when it\'s in the middle-ish' do
      expect(binary_search(3, haystack)).to eq 2
    end

    it 'returns nil when the needle is off either end of the haystack' do
      expect(binary_search(-1, haystack)).to be_nil
      expect(binary_search(100, haystack)).to be_nil
    end
  end

  context 'when the haystack is empty' do
    let(:haystack) { [] }

    it 'returns nil' do
      expect(binary_search(0, haystack)).to be_nil
    end
  end

  context 'when the haystack has one element' do
    let(:haystack) { [3] }

    it 'returns nil if needle not present' do
      expect(binary_search(5, haystack)).to be_nil
    end

    it 'returns 0 if needle present' do
      expect(binary_search(3, haystack)).to eq 0
    end
  end

  context 'when the haystack is large' do
    let(:haystack) { [*1..1337] }

    it 'can find every value' do
      (1..100).each do |i|
        expect(binary_search(i, haystack)).to eq(i - 1)
      end
    end
  end
end

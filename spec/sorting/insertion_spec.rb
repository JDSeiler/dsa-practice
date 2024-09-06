require 'rspec'
require_relative '../../util'

describe '#insertion_sort' do
  let(:unsorted) { random_ints }

  it 'returns an empty array if given an empty array' do
    expect(insertion_sort([])).to eq([])
  end

  it 'returns a single element sorted array if given an array with one element' do
    expect(insertion_sort([5])).to eq([5])
  end

  it 'correctly sorts arrays of integers in ascending order' do
    expect(is_sorted?(insertion_sort(unsorted), :asc)).to be true
  end

  context 'edge cases' do
    let(:single_element_array) { [5] }
    let(:two_element_array) { [3, 1] }

    it 'handles single element arrays correctly' do
      expect(insertion_sort(single_element_array)).to eq(single_element_array)
    end

    it 'handles two element arrays correctly' do
      expect(insertion_sort(two_element_array)).to eq([1, 3])
    end
  end
end

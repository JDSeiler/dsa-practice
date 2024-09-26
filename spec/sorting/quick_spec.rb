require 'rspec'
require_relative '../../util'
require_relative '../../src/sorting/quick'

describe '#quicksort' do
  let(:unsorted) { random_ints }

  it 'returns an empty array if given an empty array' do
    expect(quicksort([])).to eq([])
  end

  it 'returns a single element sorted array if given an array with one element' do
    expect(quicksort([5])).to eq([5])
  end

  it 'correctly sorts arrays of integers in ascending order' do
    output = quicksort(unsorted)
    expect(sorted?(output, :asc)).to be true
    # Compare to the built in Ruby sort method to protect against
    # Errors like dropping or duplicating elements
    expect(output).to eq(unsorted.sort)
  end

  context 'edge cases' do
    let(:single_element_array) { [5] }
    let(:two_element_array) { [3, 1] }
    let(:odd_array) { [7, 5, 9, 3, 11] }
    let(:even_array) { [4, 2, 8, 12] }
    let(:dupe_array) { [10, 4, 3, 3, 3, 2, 5, 5, 1, 5, 5, 3, 3, 15, -10, 48, 1, 2, 2] }

    it 'handles single element arrays correctly' do
      expect(quicksort(single_element_array)).to eq(single_element_array)
    end

    it 'handles two element arrays correctly' do
      expect(quicksort(two_element_array)).to eq([1, 3])
    end

    it 'handles odd length array correctly' do
      expect(sorted?(quicksort(odd_array), :asc)).to be true
    end

    it 'handles even length array correctly' do
      expect(sorted?(quicksort(even_array), :asc)).to be true
    end

    it 'handles array with many duplicates correctly' do
      expect(sorted?(quicksort(dupe_array), :asc)).to be true
    end
  end
end

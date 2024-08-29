require 'rspec'
require_relative '../util'

describe '#random_ints' do
  it 'generates an array of random integers' do
    expect(random_ints.size).to eq(100)
  end

  it 'generates integers within the specified range' do
    expect(random_ints(100, (-50..50)).min).to be >= -50
    expect(random_ints(100, (-50..50)).max).to be <= 50
  end

  it 'generates integers within the default range' do
    expect(random_ints.min).to be >= -100
    expect(random_ints.max).to be <= 100
  end
end

describe '#is_sorted?' do
  it 'returns true for an already sorted array in ascending order' do
    expect(is_sorted?([1, 2, 3])).to eq(true)
  end

  it 'returns false for an unsorted array in ascending order' do
    expect(is_sorted?([3, 2, 1])).to eq(false)
  end

  it 'returns true for an already sorted array in descending order' do
    expect(is_sorted?([3, 2, 1], :desc)).to eq(true)
  end

  it 'returns false for an unsorted array in descending order' do
    expect(is_sorted?([1, 2, 3], :desc)).to eq(false)
  end

  it 'returns false for arrays with issues on the end' do
    expect(is_sorted?([1, 2, 3, 2])).to eq(false)
    expect(is_sorted?([1, 2, 3, 4, 3])).to eq(false)
  end

  it 'returns false for arrays with issues at the start' do
    expect(is_sorted?([1, -1, 3, 4])).to eq(false)
    expect(is_sorted?([3, 2, 4, 5])).to eq(false)
  end

  it 'returns false for arrays with issues in the middle-ish' do
    expect(is_sorted?([1, 2, 3, 4, 3, 4, 5, 6])).to eq(false)
    expect(is_sorted?([1, 2, 3, 4, 10, 9, 7, 8, 9])).to eq(false)
  end

  it 'returns true for an empty array' do
    expect(is_sorted?([])).to eq(true)
    expect(is_sorted?([], :desc)).to eq(true)
  end

  it 'returns true for an array of one element' do
    expect(is_sorted?([1])).to eq(true)
    expect(is_sorted?([1], :desc)).to eq(true)
  end

  it 'works correctly with arrays of differing lengths' do
    even_len = [1, 2, 3, 4, 5, 6]
    odd_len = [1, 2, 3, 4, 5, 6, 7]

    expect(is_sorted?(even_len)).to eq(true)
    expect(is_sorted?(odd_len)).to eq(true)
  end

  it 'raises an error if the direction is not asc or desc' do
    expect { is_sorted?([1, 2, 3], :invalid) }.to raise_error(ArgumentError)
  end
end

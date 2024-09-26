# frozen_string_literal: true

require 'benchmark'
require_relative '../util'
require_relative '../src/searching/linear'
require_relative '../src/searching/binary'
require_relative '../src/sorting/insertion'
require_relative '../src/sorting/merge'
require_relative '../src/sorting/quick'

puts 'Numbers have no absolute meaning.'
puts 'Only compare numbers between algorithms of the same type.'
puts 'SEARCH ALGORITHMS:'
Benchmark.bm(20) do |b|
  size = 10_000
  value_range = ((-3 * size)..(3 * size))
  haystack = random_ints(size, value_range).sort!
  b.report('linear_search:') do
    100.times do
      needle = rand(value_range)
      linear_search(needle, haystack)
    end
  end

  b.report('binary_search:') do
    100.times do
      needle = rand(value_range)
      binary_search(needle, haystack)
    end
  end
end

puts "\nSORTING ALGORITHMS:"
Benchmark.bm(20) do |b|
  unsorted_sm = random_ints(100, (-300..300))
  unsorted_md = random_ints(1_000, (-3000..3000))
  unsorted_lg = random_ints(10_000, (-30_000..30_000))
  unsorted_xl = random_ints(100_000, (-300_000..300_000))

  b.report('insertion_sort (sm):') do
    10.times do
      insertion_sort(unsorted_sm)
    end
  end
  b.report('insertion_sort (md):') do
    10.times do
      insertion_sort(unsorted_md)
    end
  end
  b.report('insertion_sort (lg):') do
    10.times do
      insertion_sort(unsorted_lg)
    end
  end

  b.report('merge_sort (sm):') do
    10.times do
      merge_sort(unsorted_sm)
    end
  end
  b.report('merge_sort (md):') do
    10.times do
      merge_sort(unsorted_md)
    end
  end
  b.report('merge_sort (lg):') do
    10.times do
      merge_sort(unsorted_lg)
    end
  end
  b.report('merge_sort (xl):') do
    10.times do
      merge_sort(unsorted_xl)
    end
  end

  b.report('quicksort (sm):') do
    10.times do
      quicksort(unsorted_sm)
    end
  end
  b.report('quicksort (md):') do
    10.times do
      quicksort(unsorted_md)
    end
  end
  b.report('quicksort (lg):') do
    10.times do
      quicksort(unsorted_lg)
    end
  end
  b.report('quicksort (xl):') do
    10.times do
      quicksort(unsorted_xl)
    end
  end
end

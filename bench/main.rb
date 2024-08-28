# frozen_string_literal: true

require 'benchmark'
require_relative '../src/searching/linear'
require_relative '../src/searching/binary'
require_relative '../util'

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

# frozen_string_literal: true

def random_ints(size = 100, range = (-100..100))
  (1..size).map { rand(range) }
end

def is_sorted?(arr, direction = :asc)
  raise ArgumentError.new('Direction must be one of: [:asc, :desc]') unless %i[asc desc].include?(direction)

  lt_eq = proc { |a, b| a <= b }
  gt_eq = proc { |a, b| a >= b }
  comparator = lt_comparator = direction == :asc ? lt_eq : gt_eq

  arr.each_cons(2).map(&comparator).all?
end

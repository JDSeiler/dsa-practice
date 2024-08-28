# frozen_string_literal: true

def random_ints(len = 100, range = (-100..100))
  out = []
  len.times { out << rand(range) }
  out
end

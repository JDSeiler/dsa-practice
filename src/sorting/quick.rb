# frozen_string_literal: true

def quicksort(arr)
  _quicksort(arr, 0, arr.size - 1)
  arr
end

def _quicksort(arr, s, e)
  return unless s < e

  pivot_idx = _partition(arr, s, e)
  _quicksort(arr, s, pivot_idx - 1)
  _quicksort(arr, pivot_idx + 1, e)
end

# s, e -> start, end
# This is the randomized pivot algorithm from CLRS
# It is slightly magical
def _partition(arr, s, e)
  random_pivot = rand(s..e)
  _exchange(arr, random_pivot, e)

  pivot = arr[e]
  dest = s - 1
  (s..e - 1).each do |to_check|
    if arr[to_check] <= pivot
      dest += 1
      _exchange(arr, dest, to_check)
    end
  end
  _exchange(arr, dest + 1, e)
  # Location of the pivot
  dest + 1
end

def _exchange(arr, i, j)
  tmp = arr[i]
  arr[i] = arr[j]
  arr[j] = tmp
end

# frozen_string_literal: true

# haystack must be sorted
def binary_search(needle, haystack)
  return nil if haystack.empty?

  hi = haystack.length - 1
  lo = 0
  terminate = false

  until terminate
    mid = (hi + lo).div(2)
    guess = haystack[mid]
    if guess == needle
      return mid
    elsif guess < needle
      # needle is to the right
      lo = mid
    else # g > n
      # needle is to the left
      hi = mid
    end

    # wow rubocop this is so much more readable and totally not shit
    # if our interval is of width 2, check both sides.
    next unless (hi - lo).abs <= 1
    return hi if needle == haystack[hi]
    return lo if needle == haystack[lo]

    terminate = true
  end

  nil
end

# frozen_string_literal: true

def linear_search(needle, haystack)
  (0..haystack.length - 1).each do |i|
    return i if haystack[i] == needle
  end

  nil
end

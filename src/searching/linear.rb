def linear_search(needle, haystack)
  for i in 0..haystack.length - 1
    return i if haystack[i] == needle
  end

  nil
end

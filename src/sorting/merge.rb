def merge_sort(arr)
  return arr if arr.length <= 1

  left = arr.slice(0, arr.length.div(2))
  right = arr.slice(arr.length.div(2), arr.length)

  _merge(
    merge_sort(left),
    merge_sort(right)
  )
end

def _merge(l, r)
  return r if l.empty?
  return l if r.empty?

  out = []
  i = 0
  j = 0
  while out.length < l.length + r.length
    l_cand = l[i]
    r_cand = r[j]

    # l_cand XOR r_cand may be nil
    # both being nil implies we've consumed all elements from l and r
    # which means we're done... `out` is full
    if r_cand.nil?
      i += 1
      out << l_cand
    elsif l_cand.nil?
      j += 1
      out << r_cand
    elsif l_cand <= r_cand
      i += 1
      out << l_cand
    else
      j += 1
      out << r_cand
    end
  end
  out
end

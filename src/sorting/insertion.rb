def insertion_sort(arr)
  return [] if arr.empty?
  return [arr[0]] if arr.length == 1

  out = []

  arr.each do |to_place|
    inserted = false
    out.each_with_index do |sorted_elem, j|
      next unless sorted_elem >= to_place

      out.insert(j, to_place)
      inserted = true
      break
    end
    # If we didn't add the element as part of the each_with_index
    # then `to_place` must be larger than all elements in `out`
    out << to_place unless inserted
  end

  out
end

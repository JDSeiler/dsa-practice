const mergeSort = (arr: number[]): number[] => {
  if (arr.length <= 1) {
    return arr;
  }

  const middle = Math.floor(arr.length / 2);
  const left = mergeSort(arr.slice(0, middle));
  const right = mergeSort(arr.slice(middle));

  return merge(
    left,
    right
  )
}

const merge = (left: number[], right: number[]): number[] => {
  const output: number[] = [];
  const finishedLength = left.length + right.length;

  let i = 0;
  let j = 0;
  while (output.length < finishedLength) {
    // All comparisons against `undefined` return false, so we must check when
    // we've used all the items from either list
    if (left[i] <= right[j] || right[j] === undefined) {
      output.push(left[i])
      i++
    } else if (right[j] < left[i] || left[i] === undefined) {
      output.push(right[j])
      j++
    }
  }
  return output;
}

export default mergeSort;

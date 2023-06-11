const insertionSort = (arr: Array<number>): Array<number> => {
  let sortedUpTo = 0; // assume the first element is sorted
  while (sortedUpTo < arr.length-1) {
    const i = sortedUpTo + 1;
    const elemToSort = arr[i];

    let belongsAt = -1;
    for (let j = 0; j <= sortedUpTo; j++) {
      const sortedElem = arr[j];
      if (sortedElem >= elemToSort) {
        belongsAt = j;
        break;
      }
    }
    // If we never set belongsAt, elemToSort is larger than all the elements in
    // the sorted sublist, and so it belongs at the end of it.
    // Fortunately, the element started at the end of the sorted sublist, so
    // we don't have to do anything
    if (belongsAt === -1) {
      sortedUpTo += 1;
      continue;
    }

    arr.splice(i, 1); // Remove elem from current position
    arr.splice(belongsAt, 0, elemToSort); // Insert it at desired position

    sortedUpTo += 1;
  }
  return arr;
}

insertionSort([3, 2, 1])


export default insertionSort;

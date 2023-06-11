const insertionSort = (arr: Array<number>): Array<number> => {
  let sortedUpTo = 0; // assume the first element is sorted
  while (sortedUpTo < arr.length-1) {
    const i = sortedUpTo + 1;
    const elemToSort = arr[i];

    // Short circuit cases where the elemToSort is already in the place it needs to be.
    if (elemToSort >= arr[sortedUpTo]) {
      sortedUpTo += 1;
      continue;
    }

    // Otherwise, if the sublist arr[0:sortedUpTo] is sorted, and elemToSort < arr[sortedUpTo],
    // then there must be some place inside the sublist where elemToSort belongs. Find it.
    let belongsAt = -1;
    for (let j = 0; j <= sortedUpTo; j++) {
      const sortedElem = arr[j];
      if (sortedElem >= elemToSort) {
        belongsAt = j;
        break;
      }
    }

    if (belongsAt === -1) {
      throw new Deno.errors.InvalidData("insertion_sort/main.ts :: belongsAt has invalid value")
    }

    arr.splice(i, 1); // Remove elem from current position
    arr.splice(belongsAt, 0, elemToSort); // Insert it at desired position

    sortedUpTo += 1;
  }
  return arr;
}

export default insertionSort;

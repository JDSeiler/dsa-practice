const selectionSort = (arr: number[]): number[] => {
  for (let i = 0; i < arr.length; i++) {
    let minIdx: number = i;
    for (let j = i; j < arr.length; j++) {
      if (arr[j] < arr[minIdx]) {
        minIdx = j;
      }
    }
    const tmp = arr[i];
    arr[i] = arr[minIdx];
    arr[minIdx] = tmp;
  }
  return arr;
};

export default selectionSort;

type ArrayIndex = number;
export const binarySearchRecursive = (arr: number[], q: number, L = 0, R = arr.length-1): ArrayIndex | null => {
  if (L > R) {
    // TODO: Potential enhancement:
    // Write functions that return where `q` *should* be if it isn't there.
    return null; 
  }

  const M = Math.floor((R+L) / 2);

  if (arr[M] === q) {
    return M;
  } else if (q < arr[M]) {
    return binarySearchRecursive(arr, q, L, M-1);
  } else { // arr[M] < q
    return binarySearchRecursive(arr, q, M+1, R);
  }
}

export const binarySearchLooping = (arr: number[], q: number): ArrayIndex | null => {
  let L = 0;
  let R = arr.length - 1;

  while (L <= R) {
    const M = Math.floor((R+L) / 2);
  
    if (arr[M] === q) {
      return M;
    } else if (q < arr[M]) {
      R = M-1;
    } else { // arr[M] < q
      L = M+1;
    }
  }
  return null;
}

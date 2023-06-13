const linearSearch = (arr: number[], q: number): number | null => {
  for (let i = 0; i < arr.length; i++) {
    if (arr[i] === q) {
      return i;
    }
  }
  return null;
};

export default linearSearch;

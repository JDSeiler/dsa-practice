export const isSorted = (a: Array<number>): boolean => {
  for (let i = 0; i < a.length - 1; i++) {
    const x = a[i];
    const y = a[i + 1];
    if (x > y) {
      return false;
    }
  }
  return true;
};

type GenerationBounds = { lower: number; upper: number };
export const randArrayOfSize = (
  n: number,
  { lower, upper }: GenerationBounds,
): Array<number> => {
  const out = [];
  for (let i = 0; i < n; i++) {
    out[i] = generateInRange(lower, upper);
  }
  return out;
};

export const generateInRange = (lower: number, upper: number): number => {
  const rangeSize = Math.abs(upper - lower);
  return Math.round(Math.random() * rangeSize + lower);
};

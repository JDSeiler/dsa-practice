import { randArrayOfSize } from "./common.ts";
import insertionSort from "./insertion_sort/main.ts";

// Maybe expand to do benchmarks across a range of input sizes.
const LARGE_INPUT = randArrayOfSize(10000, { lower: 0, upper: 8000 });

Deno.bench("insertionSort", { group: "insertion_sort", baseline: true }, () => {
  const input = [...LARGE_INPUT];
  insertionSort(input);
});

Deno.bench("Array#sort", { group: "insertion_sort" }, () => {
  const input = [...LARGE_INPUT];
  input.sort();
});
